public: yes
tag: [pyramid, repoze]

========================================
repoze.who 实现"记住我"功能
========================================

至今没有去思考和深究"为什么pyramid有repoze.who好好的不去用, 而再次实现自己的authentication."

今天要为用repoze.who实现的登录功能添加个"remember me"功能, 辗转了好几个地方才算是解决.

repoze.who的plugins *AuthTktCookiePlugin* 提供的两个初始参数, timeout和reissue_time, 
`官方文档 <http://docs.repoze.org/who/1.0/narr.html>`_ 如是说(1.0版本, 2.0的文档当前未完整)::

   If timeout is specfied, it is the maximum age in seconds allowed for a cookie.
   If reissue_time is specified, when we encounter a cookie that is older than
   the reissue time (in seconds), but younger that the timeout, a new cookie will 
   be issued. If timeout is specified, you must also set reissue_time to a lower value.


比较笼统, 还颇带误导成分. 看pyramid的 `pyramid.authentication.AuthTktAuthenticationPolicy 
<http://docs.pylonsproject.org/projects/pyramid/1.2/api/authentication.html#module-pyramid.authentication>`_ 
的文档说明或者更清晰点::
  
   timeout

      Default: None. Maximum number of seconds which a newly issued ticket will be considered valid.
      After this amount of time, the ticket will expire (effectively logging the user out).
      If this value is None, the ticket never expires. Optional.

   reissue_time

      Default: None. If this parameter is set, it represents the number of seconds that must pass 
      before an authentication token cookie is automatically reissued as the result of a request 
      which requires authentication. The duration is measured as the number of seconds since the 
      last auth_tkt cookie was issued and ‘now’. If this value is 0, a new ticket cookie will be 
      reissued on every request which requires authentication.

      A good rule of thumb: if you want auto-expired cookies based on inactivity: set the timeout 
      value to 1200 (20 mins) and set the reissue_time value to perhaps a tenth of the timeout 
      value (120 or 2 mins). It’s nonsensical to set the timeout value lower than the reissue_time 
      value, as the ticket will never be reissued if so. However, such a configuration is not 
      explicitly prevented.

      Optional.

如pyramid文档说, timeout和reissue_time其实是服务器端处理的. 截取源码:

.. sourcecode:: python

   #in repoze.who.plugins.auth_tkt.py line-71
   #IIdentifier
   if self.timeout and ( (timestamp + self.timeout) < time.time() ):
       return None


而一般所说的cookie过期应该是客户端的, 过期的cookie不会发送到服务器段, 要设定的应该时max_age参数, pyramid文档::

    max_age

    Default: None. The max age of the auth_tkt cookie, in seconds. This differs from timeout inasmuch 
    as timeout represents the lifetime of the ticket contained in the cookie, while this value represents 
    the lifetime of the cookie itself. When this value is set, the cookie’s Max-Age and Expires settings 
    will be set, allowing the auth_tkt cookie to last between browser sessions. 
    It is typically nonsensical to set this to a value that is lower than timeout or reissue_time, 
    although it is not explicitly prevented. Optional.


repoze.who中auth_tkt的max_age不在初始化中传递, 发现在remember中在参数identity中尝试获取. 文档只字未提, `Repoze Issue87 <http://bugs.repoze.org/issue87>`_ 有相关信息.::

   in remember now you get					       
   max_age = identity.get('max_age', None)
   and _get_cookies correctly sets it


其实问题解决的缺口在repoze.who-friendlyform, 在其源码中

.. sourcecode:: python

   try:
	credentials['max_age'] = form['remember']
   except KeyError:
        pass

不过明显不符合需求. "remember"一般是checkbox吧, 而不是上面那样是"max_age"的值. 将其修改为:

.. sourcecode:: python
  
   if form.get('remember'):
       credentials['max_age'] = the-max_age-value

如果不想这样pitch, 就自己实现个继承friendlyform.FriendlyFormPlugin的class, 覆盖其identity函数, 同时能灵活处理*max_age*值的获取方式. 我把自己的实现放在了github的 `这里 <https://github.com/Tukki/codesnippet/blob/master/python/friendlyform_fix_rememberme.py>`_

[Wed Oct 26 20:41:10 CST 2011]
