public: yes
tags: [pyramid, nginx]

============================
Notes for Pyramid with Nginx
============================


pyramid_cookbook上的 `Nginx + paster + supervisord
<https://docs.pylonsproject.org/projects/pyramid_cookbook/dev/deployment/nginx.html>`_. 


PasteScript#cherrypy使用
-------------------------------

the pyramid cookbook在当前(v0.1)版本, 使用PasteScript#cherrypy作为server::

   [server:main]
   host = 127.0.0.1
   port = %(http_port)s

   use = egg:PasteScript#cherrypy
   numthreads = 10
   timeout = 180
   request_queue_size = 200


如果使用Pastecript-1.7.4.2版本, 会抛出::

   lib/python2.5/site-packages/paste/script/cherrypy_server.py", line 4, in <module>
   import paste.script.wsgiserver as wsgiserver
   ImportError: No module named wsgiserver


在PasteScript的BitBucket有相关记录 `Issue #1
<https://bitbucket.org/ianb/pastescript/issue/1/no-module-named-pastescriptwsgiserver>`_::

  The module paste.script.wsgiserver seems to have been removed when going from 1.7.3 to 1.7.4.


如果一定要使用这配置, 使用pastescript==1.7.3版本才行. 官方文档需要更新了.

疑问: 查看cherry_server.py的 `history
<https://bitbucket.org/ianb/pastescript/changeset/8e8ae01e5231#chg-paste/script/cherrypy_server.py>`_, 07年已经不再依赖CherryPy. 那CherryPy一直以来的更新和优化, 是不是一致没有用上? 



使用PasteDeploy的prefixMiddleware
----------------------------------------

在[filter:paste_prefix]中添加::

  prefix = /prefix

然后在nginx的location可以设置对应的prefix. 



