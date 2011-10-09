public: yes
tags: [nginx]

===============================================
using nginx virtual host without default port
===============================================


In the Nginx `Virtual Host official examples
<http://wiki.nginx.org/VirtualHostExample>`_ showing how to setup the Virtual Host with default port *80*, and tell us can replace 80 with the right one for our requirements. It souds great.

This tiem I just want to setup my pyramid project with nginx just like `pyramid cookbook
<https://docs.pylonsproject.org/projects/pyramid_cookbook/dev/deployment/nginx.html>`_
showing. All things smoothly going except the PasteScript missing 'wsgiServer'. But the nightmare appearanced when I changed the listening port to *8080* - all the links point to 'localhost', yet, there was no 8080. Google for it and try the solutions, only the this worked.::

   proxy_set_header Host $host:8080

Checked the Nginx `HttpProxyModele
<http://wiki.nginx.org/HttpProxyModule#proxy_set_header>`_ document::

   The unchanged request-header "Host" can be transmitted like this:

       proxy_set_header Host $http_host;

   However, if this line is absent from the client request,
   then nothing will be transferred.

   In this case it is better to use variable $host, 
   it's value is equal to the name of server in the request-header "Host"
   or to the basic name of server, if there is no line:

       proxy_set_header Host $host;

   Furthermore, it is possible to transmit the name of server together
   with the port of the proxied server:

       proxy_set_header Host $host:$proxy_port;


Sound like the *$proxy_port* is the general and perfect solution. But I'm wrong, it did not work. If I only use the $proxy_port, the links show me that the value is **0.0.80**. WTH... 

Anyway, these configures work::

  proxy_set_header Host $http_host;
  
or::

  proxy_set_header Host $host;

