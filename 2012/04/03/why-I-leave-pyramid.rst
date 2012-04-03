public: yes
tags: [webdev, python, pyramid]
summary: |
    离开, 纯属个人喜好, 非基于技术性的选择

Why I leave Pyramid
=================================

`Pyramid <http://www.pylonsproject.org/>`_, Pylons和Repoze.bfg两个框架的合并产物. 2011年下半年用来做个两个最后失败只有上线没有运营的工程. 现在, 已经确认未来有一段时间不会再用其来构建python web project. 离开, 纯属个人喜欢, 非基于技术性的选择.

一开始, 只是在享受django带来方便的同时, 不适应其居多的限制. 作为一个爱折腾喜欢灵活的人, 开始尝试 pylons + sqlalchemy. 却又适逢Pylons停止开发, 和Repoze.bfg衍生出Pyramid, 出于技术框架的在开源社区上面的支持程度来作长远的考虑 -- 回想这一点, 觉得有点不妥, startup的时候, 长远考虑不一定是件好事, 未来变化太多了, startup或者应该用熟悉的工具尽快起步 -- 于是改用了Pyramid.::

  Web development with style, your way! 

这句吸引了我. 但事实上, 自己对 web development 还没有自己的style. 不过, 里面一个单文件就搭建好一个简单的application, 至少当时对于只用过django的我是很吸引的. 当然django也可以做到, 其他框架也至此(web.py, flask). 借口! 灵活性吸引了我.

django外面的世界, Template上面mako, jinja2都比django内置的强大(个人认为) form也更多的选择, django的orm在非django环境下面使用有点麻烦. 这些, 在Pylons/Pyramid上面都能自主选择.

也许是太灵活, 而且我还是个版本控, 导致还没有style的我在选择上面走了不少弯路. 

1.0/1.1版的文档没有1.3版的清晰, 主推过Traversal, 事实上更多人习惯的是Route. 

内置的时Chameleon Template, 要用Mako还需要额外配置一下. 

内置的Authorization Policy, 感觉还不如用repoze.who/repoze.what. 一直就想不明白, 作为一个"灵活的框架", 要内置的Authorization Policy干啥, 想原Pylons那样, 指导用可选的第三方实现不是一样可以吗?

现在第三方依赖和第三方可选是两回事. Pyramid一开始时第三方依赖严重, 导致版本升级协调难. 在WebOb和Paste上面就载过跟斗. 后来Pyramid把Paste也舍弃了, 直接内置了相关的实现,(应该没记错). 也不知道算不算是间好事.

可能, 当时最不习惯的, 莫过于interfaces了. 是Python不是Java吧.

其实, 更多还是个人原因, 用一样的东西就喜欢全局地看其功能, 去了解其底层的实现. 而且自己还不是一个在深入研究python web framework的人. 所以, pyramid的灵活性, 不是我现在要去handle的. 灵活又小的框架, 现在有个想法, I will get `Flask <http://flask.pocoo.org/>`_ a try.

不想掉入什么语言之争, 框架之争. 用合适的工具来解决问题. sorry, Pyramid. 在索取阶段已经选择离开, 还没作建设性的回馈. 有机会, 再合作.

balabala又一个小时, 回看, 实在没什么建设性的内容. 总结能力要继续提高才行.

<Tue Apr  3 16:38:33 CST 2012>



