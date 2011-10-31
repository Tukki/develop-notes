public: yes
tags: [pyramid]

=========================================
Pyramid Authentication and Authorization
=========================================

Forbidden vs Unauthorized
------------------------------

`官方1.2文档 <http://docs.pylonsproject.org/projects/pyramid/1.2/narr/security.html>`_::

  if the authorization policy denies access, the view callable is not invoked; 
  instead the Forbidden view is invoked.

不满足权限要求, 抛出 *pyramid.httpexceptions.HTTPForbidden*, 即使使用 `security.Authenticated <http://docs.pylonsproject.org/projects/pyramid/1.2/api/security.html#pyramid.security.Authenticated>`_, 得到的也是Forbidden的403, 而不是Unauthorized的401. 

对于某资源, 非登录用户无权限访问而显示个登录界面是个不错的用户体验; 但对于登录用户无权限访问时, 给对方显示个登录界面颇为不妥. 至今了解到的资料, 在pyramid默认的auth机制中, 分离 *login_required* 和 *permission* 还得额外处理.


default permission
--------------------------

`Setting a Default Permission <http://docs.pylonsproject.org/projects/pyramid/1.2/narr/security.html#setting-a-default-permission>`_

避免循环, 对于 *HTTPForbidden View* 要开放权限 `pyramid.security.NO_PERMISSION_REQUIED <http://docs.pylonsproject.org/projects/pyramid/1.2/api/security.html#pyramid.security.NO_PERMISSION_REQUIRED>`_:

.. sourcecode:: python

    #默认都得登录才能访问
   config.set_default_permission('login_required')

   config.add_view('project.views.login', 
                   renderer='login.mako',
		   context='pyramid.httpexceptions.HTTPForbidden',
		   permission=NO_PERMISSION_REQUIRED'
		   )
   


traversal context
-------------------------

访问无权限时直接显示登录界面而不作跳转. 以前在Django学到的方式是: 用decorator判断, 直接调用login_view作为返回. 而在pyramid可以用traversalh直接设定context:

.. sourcecode:: python

   config.add_view('project.views.login',
                   renderer='login.mako',
		   context='pyramid.httpexceptions.HTTPUnathorized',
		   )

注意上面的代码没有"route_name", 即使带"route_name"也会被忽略, 导致无法直接访问登录页面. 解决方法是再用 `URL Dispatch <http://docs.pylonsproject.org/projects/pyramid/1.2/narr/urldispatch.html#urldispatch-chapter>`_ 的方式再添加登录界面一次. (traversal的方式, 还没搞明白)

 

Pyramid "Auth" API Design Postmortem
---------------------------------------------

Chrism写得API设计验尸报告, http://plope.com/pyramid_auth_design_api_postmortem

1. The "groupfinder" is a "knob on a knob". A Pyramid authentication policy is already replaceable wholesale; you can write a custom authentication policy and use it as necessary. However, because writing a custom authentication policy no fun, the default authentication policies themselves have become miniframeworks by allowing (really, requiring) a user to pass a "groupfinder" function. This is a common source of confusion. It would be much better if there was only one "knob" for a user to turn: registering a custom authentication policy, rather than two (allowing a custom authentication policy or allowing them to use the groupfinder miniframework with stock authentication policies). But for it to be feasible for a nonexpert user to create an authentication policy, the contract of the policy itself needs to be simpler.

 
2.  If the user wants to control the horizontal and vertical of authorization, they have to override both the authentication policy and the authorization policy bacause both rely on persistent storage local to the application itself. This is bad.


只需要简单的登录验证, 默认提供的auth机制的确够用了. 复杂一点的就选择repoze.who. 为在pyramid上面使用repoze.who提供了个支持.

[Mon Oct 31 15:18:23 CST 2011]
