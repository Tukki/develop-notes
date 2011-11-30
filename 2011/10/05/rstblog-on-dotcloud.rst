public: yes
tags: [rstblog, paas]

======================================
在dotcloud部署rstblog
======================================

不用heroku部署的原因只有一个, 不想再对生成出来的静态文件再做一次git的源码管理.

在dotcloud部署static service的 `官方教程
<http://docs.dotcloud.com/services/static/>`_ 
图文并茂. 唯一注意的时, 文中例子的dotcloud.yml和hellostatic文件夹时在统一父目录下的, 在dotcloud.yml里面用approot标识static directory. 采用此方式在rstblog的目录结构下, 回把所有的源文件都备份到dotcloud上面. 这个并不是我想要的, 我只要上传_build里面的文件就够了. 那就只利用makefile和rsync保证dotcloud.yml在_build里面, 只上传_build文件夹::

 upload:
    rsync -a static/dotcloud.yml _build/dotcloud.yml
    dotcloud push notes _build/
    @echo "Done..."


这样一来, make upload的时候, 就不怕clean操作把dotcloud.yml文件删掉了.ps.Makefile, dotcloud.yml都在static有备份

(Wed Oct  5 17:15:14 CST 2011)

   

