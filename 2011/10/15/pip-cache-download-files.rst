public: yes
tag: [python]

=======================
设置pip缓存安装文件
=======================

用pylons/pyramid开发, 总有一大堆依赖. 如果用 `virtualenv <http://pypi.python.org/pypi/virtualenv>`_ , 要是没有用或不应该用 `virtualenvwrapper <http://pypi.python.org/pypi/virtualenvwrapper>`_ 的 `cpvirtualenv <http://www.doughellmann.com/docs/virtualenvwrapper/command_ref.html#cpvirtualenv>`_ 命令复制一份运行环境, 则每新开一个工程都要在网上下载一次. 

可能是平时网速不差, 没在意. 知道用heroku部署pyramid工程的时候, 在其部署信息中看到pip的都是本地文件. 才想起这个问题. Google一翻, 发现官方解决方案 *$PIP_DOWNLOAD_CACHE*, 但不明白的是, 这个是*Undocument Feature*. stackoverflow已有 `Question <http://stackoverflow.com/questions/4806448/how-do-i-install-from-a-local-cache-with-pip>`_ 得到解答. 这里把答案Copy过来做个记录.

from http://stackoverflow.com/questions/4806448/how-do-i-install-from-a-local-cache-with-pip

Form the `pip news <http://pip.openplans.org/news.html>`_, viersion 0.1.4:

  Added support for an environmental variable $PIP_DOWNLOAD_CACHE which will
  cache package downloads, so future installations won’t require large downloads. 
  Network access is still required, but just some downloads will be avoided 
  when using this.

To take advantage of this, I've added the following to my ~/.bash_profile: ::
  
  export PIP_DOWNLOAD_CACHE=$HOME/.pip_download_cache    

Notes:
1. If a newer version of a package is detected, it will be downloaded and added to the PIP_DOWNLOAD_CACHE directory. For instance, I now have quite a few Django packages. 
2. This doesn't remove the need for network access, as stated in the pip news, so it's not the answer for creating new [virtualenv][]s on the airplane, but it's still great.

原来还是需要网络链接. 看来网络差的时候, 还是得用*cpvirtualenv*.

Thought: 如果是在局域网, 应该可以把这个cache位置指向同一文件服务器. 应该可以减少不少冗余

[Sat Oct 15 01:07:30 CST 2011]






  
