public: yes
tag: [uwsgi, supervisor]

========================
 用supervisor管理uWSGI
========================


`Supervisor <http://supervisord.org>`_, is a client/server system that allows its users to monitor and control a bumber of processes on UNIX-like operation systems. 飞龙博客有篇<用Supervisord管理Python进程>, `Here <http://feilong.me/2011/03/monitor-processes-with-supervisord>`_. 还有篇 `<Django on uWSGI and Nginx> <http://brandonkonkle.com/blog/2010/sep/14/django-uwsgi-and-nginx/>`_ 里面也有涉及在supervisor中管理uWSGI::

   [program:myapp]
    command=/usr/local/sbin/uwsgi
      --home /home/myuser/.virtualenvs/myapp/
      --module myapp.deploy.wsgi
      --socket 10.1.2.3:10000
      --pythonpath /sites/myapp.com/code/myapp
      --processes 5
      --master
      --harakiri 120
      --max-requests 5000
    directory=/sites/myapp.com/code/myapp
    environment=DJANGO_SETTINGS_MODULE='myapp.settings'
    user=www-data
    autostart=true
    autorestart=true
    stdout_logfile=/sites/myapp.com/logs/uwsgi.log
    redirect_stderr=true
    stopsignal=QUIT

在uWSGI指定了--master/-M, supervisor没有设置stopsignal=QUIT(默认为TERM)情况, supervisor stop program后, 显示是*stopped*, 但其实uWSGI依旧在运行, 在stackoverflow有个非直接解析, `这里 <http://stackoverflow.com/questions/5430370/django-uwsgi-nginx-process-dies-for-no-reason>`_::
  
   You should always add --master/-M on uwsgi even under supervisord, this will allow to restart apps without losing the socket (and without spitting out an error to clients during restart).

uWSGI的master是个好东西, 但supervisor默认的stopsignal使uWSGI挂了一次, 然后uWSG的master又重启apps. 不注意细节带来的非期望结果.

supervisor把program转为daemon模式, 所以uWSGI不用自己加deamonize.

ps. 控制supervisor的program启动顺序, 用的是priority, "Higer priorities indicate programs that start last and shut down first"

[Wed Oct 12 01:19:41 CST 2011]



   
