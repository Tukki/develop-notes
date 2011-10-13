public: yes
tag: [python, django]

=============================================
使用decorator增强Django的login_required
=============================================


PS. 感谢open-sources, 感谢pylons, 感谢django. 

在pylons的第三方依赖中, 有 `decorator
<http://pypi.python.org/pypi/decorator>`_. 查看其 `文档
<http://micheles.googlecode.com/hg/decorator/documentation.html>`_, 才
发现 `functools.update_wrapper
<http://docs.python.org/release/2.5.2/lib/module-functools.html>`_ 并非
完全解决问题, 在用到自省工具(introspection tools), 如pydoc的时候, 会得到错误的参数标识. 因为functools是在开Django的源码时发现的, 所以拿了其contrib.auth下的login_required来确认:

.. sourcecode:: python

    # using python2.5.4
    def home(request, template_name='home.html'):
        pass
	
    >>> from inspect import getargspec
    >>> print getargspec(home)  #可以看到完整的参数信息
    (['request', 'template_name'], None, None, ('home.html',))
    
    >>> from django.contrib.auth.decorators import login_required
    >>> print getargspec(login_required(home)) #参数信息丢失
    (['request'], 'args', 'kwargs', None)

Django的login_required实际调用了*user_passes_test*, 而user_passes_test里面用了functools的wraps:

.. sourcecode:: python

   def user_passes_test(...):
       def decorator(view_func):
           @wraps(view_func, assigned=available_attrs(view_func)):
       	   def _wrapped_view(request, *args, **kwargs):
	       pass
	   return _wrapped_view
       return decorator

尝试用decorator代替wraps:

.. sourcecode:: python

   from decorator import decorator

   def user_passes_test(...):
       def _decoratord(view_func):
           def _wrapped_view(request, *args, **kwargs):
	       pass
	   return decorator(_wrapped_view, view_func)
       return _decoratord
   
   >>> print getargspec(login_required(home))     #再测试一次home
   (['request', 'template_name'], None, None, ('home.html',))
 
可以看到, 原home函数的参数信息回来了.

现在想, 这点不是错误的错误在某种程度接受. 现在遇到的实现, 其文档好多都是独立rst文件.

不过对于自己还没有懒写独立文档的情况下, 用这个第三方的decorator实现来协作实现python的decorator功能, 感觉会比functools.wraps有点优势.

(Fri Oct 14 00:37:18 CST 2011)


   
 
