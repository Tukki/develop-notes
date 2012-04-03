public: yes
tags: [webdev, python, django]
summary: |
   对django, wsgi的middleware的不完整记录

Notes for Middleware
==============================

还没认真地去看PEP333, 只是记录

以前用django的时候, 没有区分好其内置的 `Django Middleware <https://docs.djangoproject.com/en/dev/topics/http/middleware>`_ 和标准下的 `WSGI Middleware <http://www.python.org/dev/peps/pep-0333/#id17>`_. 直到离开过Django, 才明白为什么叫 "Django lets you write web apps in Django"

django把wsgi隐藏的太好了. 以致我曾认为wsgi就是django这样的. environ真的很少用到.

现在看来, django的middleware是对wsgi的middleware在django层面的再封装, 提供django-like的实现方式: process_request, proces_response, etc. 模仿PJE的说法 `If your appkication requires that API to be present, then it's not middleware any more! <http://dirtsimple.org/2007/02/wsgi-middleware-considered-harmful.html>`_, django的middleware更多时候, 是application的一部分, 其复用程度, 局限于django工程.

这里匆忙找到的两篇博文, `Python WSGI Middleware for automatic Gzipping <http://www.evanfosmark.com/2008/12/python-wsgi-middleware-for-automatic-gzipping/>`_ 介绍了如何写WSGI标准的Middleware; `WSGI Middleware is Awesome, and Django Should Use It More <http://eflorenzano.com/blog/2008/11/17/wsgi-middlware-awesome-django-use-it-more/>`_, 介绍1.4之前如何整合django和其他Middleware实现.

对于WSGI, 在django的1.4出来后更好的支持, `Improved WSGI support <https://docs.djangoproject.com/en/dev/releases/1.4/#improved-wsgi-support>`_, 或者, django要回归WSGI生态圈了, 事实上, 我不确认django是否离开过

<Tue Apr  3 22:07:13 CST 2012>

