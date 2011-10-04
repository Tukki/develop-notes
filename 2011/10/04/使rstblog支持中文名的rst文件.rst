public: yes
tags: [python, rstblog]

=============================
使rstblog支持中文名的rst文件
=============================


本人使用的系统环境, Fedora 14, LANG设定en_us.UTF-8. 安装的是 `github 
<https://github.com/mitsuhiko/rstblog>`_
上rstblog的最新版本(commit 90ca1426a2). 如果以中文作为rst文件名(像本文), 在build时会抛出异常::

    File "/home/lazy/.virtualenvs/rstblog/lib/python2.7/site-packages
    /Werkzeug-0.8.1-py2.7.egg/werkzeug/contrib/atom.py", line 309, in generate
    yield u'  <id>%s</id>\n' % escape(self.id)
    UnicodeDecodeError: 'ascii' codec can't decode byte 0xe4 in position 33:
     ordinal not in range(128)
    make: *** [build] Error 1

根据trace信息可以知道时Werkzeug在生成Atom时抛的错误. 查看源码, 可以知道entry时Werkzeug.atom.FeedEntry的实例, 其在初始化的时候, 如果没找到id值, 就使用url作为id值. 而rstblog是使用slug作为其url的. 这样一来, 找到修改可能了

找到rstblog.builder.Context. 文档说是"Per rendering information", 初始化就带了source_filename. 估计修改这里比较安全(未对rstblog的源码通读). **注意下面的修改方式只能证明在我的Fedoar下能行, 不确保是否完全正确, 或在其他平台也能用**

修改方式为把source_filename再decode一次. 因为是系统上的文件, 所以可以用sys.getfilesystemencoding()获取编码方式:

.. sourcecode:: python

    #place in builder.py
    import sys
    default_encode = sys.getfilesystemencoding()

    #in Context.__init__()
    self.source_filename = source_filename.decode(default_encode)

再run_rstblog build一次, 这次没有报错.在debug_serve下测试页成功显示. 至于生成的atom是否能正确使用, 需部署到外网后再做验证
    

