public: yes
tags: [gae, python]

=============================
hosting static website on gae
=============================

起因: 突然想把部署在DotCloud上面的notes迁移到GAE上面. 理由很简单, 冲动.

获得: 
   发现GAE新版支持Jinja2
   `Application　Configuration <http://code.google.com/appengine/docs/python/config/appconfig.html>`_ 比想象中强大. 
   GAE不支持中文文件名上传. 
   fork了rstblog进行url生成的修改

失去:
   6+4 小时. 主要时间放在了URL后面的 *trailing slash* 上面


Static Files on GAE
-----------------------

首先是 `官方文档 <http://code.google.com/appengine/docs/python/config/appconfig.html#Static_File_Handlers>`_::

  Static file handlers can be defined in two ways:
    as a directory sturcture of static files that maps to a URL path, 
    or as a pattern that maps URLs to specific files.

rstblog生成的静态文件结构::

  2011
    |-- 10
    |   |-- 04
    |   |   |-- first-rstblog-post
    |   |   |   `-- index.html
    |   |   `-- make-rstblog-support-chinese-filename
    |   |   |    `-- index.html
    |   |    `-- index.html
    |   `-- index.html

用 `Static Directory Handlers <http://code.google.com/appengine/docs/python/config/appconfig.html#Static_Directory_Handlers>`_ 映射这个目录结构. 因为全部都是静态文件, 所以URL就不用前序了::

  - url: /
    static_dir: rstblog

只是这样的话, 只能用完整路径来显示对应的文件. 而当访问一个目录时, 例如 "/2011/11/28/about-the-hacker-news-ranking/", 实际要显示的是其目录下的"index.html"文件. (rstblog生成的目录都有对应一个"index.html"来显示了该目录下的文件). 这时要用到的是 `Static File Pattern Handlers <http://code.google.com/appengine/docs/python/config/appconfig.html#Static_File_Pattern_Handlers>`_::

  - url: (.*)/
    static_files: rstblog\1/index.html
	upload: rstblog\1/index.html

正则式用的是 `POSIX extended regular expression syntax <http://en.wikipedia.org/wiki/Regular_expression%23Syntax&usg=__mBDvPGMNbDvCnmh1oLFnVOCuNwI=>`_. "以0个或者0个以上的字符"外加"/"结尾的URL, 都认为是目录, 输出其目录下的"index.html"文件内容.

看文档和相关的blog时看上去很简单. 问题却发生在实际执行中. -_-!!

rstblog对于记录的链接生成是不带"/"结尾的. 在DotCloud或者自带的开发服务器上面一直没注意到, 因为都自动加"/"后进行了redirect. 而GAE本来就不是为了部署静态文件用的, 所以不会自动识别并自动重定向. (应该这样理解?). Django也是靠在settings上面制定才会主动帮忙加.

一开始再GAE方面没找到合适的方法, 就去改rstblog的代码. 让生成的链接自动追加"/".

在github上面fork了rstblog进行修改. `Here <https://github.com/Tukki/rstblog>`_. 其实只是改了其Builder初始化时注册的"page'格式:

.. sourcecode:: python

   #self.register_url('page', '/<path:slug>') 
   self.register_url('page', '/<path:slug>/')

6小时结束.

后面四小时属于不满意上面的解决方案. 尝试写个Redirector追加"/"到URL上面.

一直没有理清思路, 也忽略了GAE的handlers配置是带先后顺序的, 匹配后就不再往下尝试. 于是发生了痛苦的事情. 

问题在于如何匹配不是指向最终文件的URL, 然后执行script追加"/". 

找到的示例都是带前序的, 有明确的pattern. 当rstblog生成的目录结构不适合这样, 也不想重构这个目录结构. 一直在试错, 最后简单点, 确定规则: 只要URI上面不带"."的, 都进行重定向::
   
   - url: /([^\.]*)
     script: redirector.app


用的是redirector用的是webapp2:

.. sourcecode:: python

   import webapp2
 
   class RedirectorHandler(webapp2.RequestHandler):
      def get(self, path):
          assert not '.' in path
      	  path = path + '/'
          self.redirect(path)

   app = webapp2.WSGIApplication([
       ('(.*)', RedirectorHandler),  #直接匹配所有.
   ], debug=True)


然后是app.yaml

.. sourcecode:: yaml

   application: scarecrow-notes
   version: 1
   runtime: python27
   api_version: 1
   threadsafe: true

   handlers:

   - url: (.*)/
     static_files: rstblog\1/index.html
	 upload: rstblog(.*)/index.html

   #不带"."的路径进入redirect状态
   - url: /([^\.]*)
     script: redirector.app

   - url: /
     static_dir: rstblog


update一下, 可行. 写记录再花4小时... 真少不了折腾.


<!-- Wed Nov 30 23:59:51 CST 2011 -->


Useful links:

- `How to Host Static Websites on Google App Engine for Free <http://www.instantfundas.com/2011/02/how-to-host-static-websites-on-google.html>`_
   里面提到的是windows环境下

- `Google AppEngine for web hosting <http://blog.engelke.com/2008/07/30/google-appengine-for-web-hosting/>`_
   这个只是没处理无"/"的情况

- `App.yaml designed for serving a static site on Google App Engine (Python). <https://gist.github.com/873098>`_
   超详细的配置文件... 指定了各种类型

-  `AppEngine “Rewrite Rules” <http://blog.engelke.com/2008/07/31/appengine-rewrite-rules/>`_
    redirector的火花从这里爆发


