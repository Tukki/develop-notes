public: yes
tags: [rstblog]

===========================
why rstblog
===========================

blogger, wordpress, myopera, 国内的新浪博客, 163博客等等, 博客服务无奇多, 还有轻博客. 其实都是服务一个目的, 记录和分享. 不同服务商提供的不同服务, 你自己按自己需求去选择合适自己的, 实在找不到解决需求的, 自己搭建一个服务自己. 开源的博客系统网上不少. 
   
就像 `wordpress
<http://www.wordpress.org>`_
PHP+MySQL, 外加大量的插件和模板, 无疑是现时最强大的开源独立博客系统. 如果没太大的灵活性要求, `wordpress.com
<http://www.wordpress.com>`_ 
提供的免费博客绝对够用, 只是不翻出去登录不了管理员后台了. 当然, 解决方法很多, 例如国内的 `BlogCN
<http://www.blogcn.com>`_
也提供了Wordress系统免费服务(注册需要手机), 或在自己购买PHP空间, 购买VPS自己搭建环境, 又或在使用Heroku/DotCloud这样的PaaS服务在上面部署.

我自己比较混乱, org-mode里面零散记了点随笔, 偶尔写点text文档的记录, 导入到evernote里面, 即作为备份, 也方便自己查找. 但分享出去比较麻烦, 而且也还不成系统, 写东西也不恒心. 权当记录. 如果再开一个blog专门记录开发上的想法和问题, 必然遇到一个重复修改/编辑/发布的问题. 也没找到好的办法同步本地text文档和博客上面的数据. 这个问题不像是在 `Keep it simple, Stupid!
<http://en.wikipedia.org/wiki/KISS_principle>`_, 倒像是在折腾.

其实, 一开始是想再看看 `org-mode
<http://orgmode.org>`_ 
的Markup-Exporting-Publishing的文档, 看这个一直在用但一直没用好的好东西能不能解决问题. 然后发现 `reStructuredText
<http://docutils.sourceforge.net/rst.html>`_, ***an easy-to-read, what-you-see-is-what-you-get plaintext markup syntax and parser system***, 被这句话吸引了, 然后才发现Sphinx是在用reStructuredText作为markup language. 经常在看Sphinx生成的文档, 却现在才知道reStructuredText的存在. Latex倒还在大学时认真地安装使用过...

算机缘巧合吧, google "python blog software", 发现 `zine
<http://zine.pocoo.org/>`_, 不过停止更新了. 然后其去作者主页 `Armin Ronacher
<http://lucumr.pocoo.org/>`_. Python一大牛. 页面很特别, 然后就发现这个的 `rstblog
<https://github.com/mitsuhiko/rstblog>`_. Armin Ronacher的这篇 `New Blog
<http://lucumr.pocoo.org/2010/11/23/new-blog/>`_ 完美解析了rstblog的诞生.

或在只是一个认同, 一个冲动, 然后就开始了. 用了官方模板, 花了点时间解决中文文件名问题, 再把一直只是在watching的github帐号建个 `repo
<https://github.com/Tukki/develop-notes>`_ 作博客(笔记更合适点吧)文件的备份. 迟点找个PaaS做个静态网站share出去, 基础设置完成

剩下的, 就是坚持了. 用make命令进行管理, build html时查错. 果然写博客和写代码都是很耗费劳力体力的活.
  (Wed Oct  5 01:49:52 CST 2011)
