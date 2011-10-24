public: yes
tag: [uWSGI]

======================
管理uwsgi
======================

Django的文档是个好东西, 即使现在不是在Django下面搞开放. Django文档的 `How to use Django with uWSGI <https://docs.djangoproject.com/en/dev/howto/deployment/uwsgi/>`_ 有比较全面的安装, 管理教程. 后来才知道uWSGI官方wiki也有个 `Management <http://projects.unbit.it/uwsgi/wiki/Management>`_, 虽然内容差不多.

pidfile::

      write the pidfile to the specified file before privileges drop
      A 'pidfile' is a plain text file containing just a process id

记录pid提供管理uWSGI的方便

vacuum::

     automatically remove unix socket and pidfiles on server exit

看中其退出时移除pidfile, 这样用fabric部署版本的时候, 可以简单根据pidfile是否存在判断uWSGI是否处于运行状态而选择start还是reload

.. TOOD english comment


managing uWSGI daemon
-------------------------

用kill来进行管理. -_-||

|  TERM for reload
|  HUP for patch
|  INT for stop. 

关于patch::

   One of the great advantages of uWSGI is its ability to gradually restart
   each worker without loosing any request.

   For example, uWSGI can be signaled that worker should reload the code 
   after handling their current request (if any) from bash::
       
      # using kill to send the signal 
         kill -HUP cat /tmp/project-master.pid
      
      # if uwsgi was started with --touch-reload=/tmp/somefile
         touch /tmp/somefile

    Or from Python::

        uwsgi.reload()

不丢失当前访问前提下restart. 看上去好实用, 在快速部署应该能起特效. 也可能带来麻烦, 重要更新一般都停服务器不?



  
