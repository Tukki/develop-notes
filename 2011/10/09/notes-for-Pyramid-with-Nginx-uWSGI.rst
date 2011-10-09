public: yes
tag: [pyramid, uWSGI]

===================================
Notes for Pyramid with Nginx, uWSGI
===================================


`Benchmark of Python WSGI Servers
<http://nichol.as/benchmark-of-python-web-servers>`_

`Running wWSGI behind Nginx
<http://projects.unbit.it/uwsgi/wiki/RunOnNginx>`_

`uWSGI wiki example
<http://projects.unbit.it/uwsgi/wiki/Example>`_
   
   add uWSGI configuration directly in your development.ini/production.ini or whatever config file you are using for Pylons::

       [uwsgi]
       socket = /tmp/i_am_a_unix_socket.sock
       master = true
       processes = 1
       ./uwsgi --ini-paste <path_to_your_pylons-configuration_file>

   finally add a location to nginx.conf::

       location / {
          include uwsgi_params;
	  uwsgi_pass unix:///tmp/i_am_a_unix_socket.sock;
       }


`Using uWSGI with virtualenv
<http://projects.unbit.it/uwsgi/wiki/VirtualEnv>`_::

   -H myenv


nice howto, Tony Landis's `Deployment Notes for Pylons, Nginx, and uWSGI
<http://tonylandis.com/python/deployment-howt-pylons-nginx-and-uwsgi/>`_






