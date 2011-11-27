public: yes
tags: [django]

======================================
why django? why not django?
======================================


`Django <https://www.djangoproject.com/>`_::

  The Web framework for perfectionisits with deadlines.
  Django makes it easier to build better Web apps more quickly and with less code.

ps. Django的发音, 'JANG-oh. The “D” is silent'. `示例 <http://red-bean.com/~adrian/django_pronunciation.mp3>`_, 我承认我这一年都发错音了, 羞大了

啄木鸟社区的 `Pythonic Web 应用平台对比 <http://wiki.woodpecker.org.cn/moin/PyWebFrameVs>`_


why Django
-----------------

但是冲着 "Django focuses on automating as much as possible and adhering to the DRY principle"一个DRY就可以考虑Django.

有一站式超详细的 `官方文档 <https://docs.djangoproject.com/en/dev/>`_

有深入浅出, 用例子引导学习的 `The Django Book <http://www.djangobook.com/>`_

有超多的pluggable apps, `pypi <http://pypi.python.org/pypi?%3Aaction=search&term=django&submit=search>`_, `django-debug-toolbar <https://github.com/django-debug-toolbar/django-debug-toolbar>`_ 就是一应常备的武器.

`内置电池 <https://docs.djangoproject.com/en/dev/#other-batteries-included>`_ 也超多. 特别是其 *Admin site* 超级好用, 如果只是对数据进行CURD, 完全可以利用按内置的 `Auto-generate the models <https://docs.djangoproject.com/en/1.3/howto/legacy-databases/>`_ 反射生成models, 再用'Admin site'进行数据管理.

还有强大的社区. 可以说"你遇到的问题很少可能是最新的".

不负责任地说, 只要有学过Python的基本语法和数据类型, 靠官方文档和The Django Book就开始建立自己的网站. 



why not Django?
-------------------------

Django is great, but why not? 用 `Ben Bangert <http://stackoverflow.com/users/95274/ben-bangert>`_ 的话来回答: 'It readlly depends on the type of application you're building.' Django再强大也不可能满足所有的需求. 

用Pylons来作对比

- `Pros/Cons of Django vs Pylons <http://stackoverflow.com/questions/48681/pros-cons-of-django-vs-pylons>`_
   
- `Why I switched to Pylons after using Django for six months <http://www.mutualinformation.org/2010/03/why-i-switched-to-pylons-after-using-django-for-six-months/>`_

- `Django vs Pylons <http://jordanovski.com/django-vs-pylons>`_

- `pylons-and-django <diffle-history.blogspot.com/2007/12/pylons-and-django.html>`_


自己经验


model query join

Template
  
 why Django

  The Django template language 很明显地区分为 "For designers" 和 "For programmmers". 

  个人陋见, 对于Designer(D)角色, 不用懂Python, 只需用学习Django的tags和filters的用法即可, 如果需要什么, 让Programmer(P)角色提供, 不管是数据还是方法. 

  而P角色只要好好地去理解template的Node和Context就能写出合适的tag和filter. 

  其中 *inclusion_tag* 在DP同在的情况下, 建议还是少用. 虽然超级好用, 比继承Node然后重写render返回数据让D调用快多了. 但维护成本增大了. 页面是多变的, 把"_header.html"固化在tag文件夹里面了, D角色改页面的时候还得去程序文件里面找对应的对用. 还不如用普通的tag返回数据然后让D角色自己 *include* 一次"_header.html". 管页面以后变成"_wft.html", 与数据无关, 与P角色无关. 当然, DP两个角色都是你的话, 自己衡量吧.


 why not Django

  Django 文档里面有句"Web designers (as opposed to developers)". 很明显的定位, 页面设计师和程序员是对立的~. 如果只有你自己一个人, 准备分演两个角色吧.
  
  内置的Template也是能替换的, `Replacing django's template language with jinja2 <http://lethain.com/replacing-django-s-template-language-with-jinja2/>`_, 但替换意味着很多contrib或者app不能直接使用了.

  Python世界还有很多html template实现. `Jinja2 <http://jinja.pocoo.org/docs>`_, `Mako <http://www.makotemplates.org/>`_, `Genshi <http://genshi.edgewall.org/>`_ 等等等等. Jinja2的语法和DjangoTemplate的就差不了多少, 过渡成本不高. Mako甚至可以把Python像PHP一样用... Django外面的世界也很精彩, 例如想用适合自己的实现, Django可能就不是满足这类需求的实现.  不过, 如果遵循MVC或者工程小, 用什么Template区别不大, 甚至可以考虑让客户端js来渲染大部分页面.


  
form

json









跑题, 其他几个框架的一句话说明
-----------------------------------------

`Pylons <http://pylonshq.com/>`_ a lightweight Web framework emphasizing flexibility and rapid development.

`Pyramid <http://www.pylonsproject.org/>`_, Web development with style, your way!
`Tornado <http://www.tornadoweb.org/>`_ is an open source version of the scalable, non-blocking web server and tools that power FriendFeed.

`Repoze.BFG <http://bfg.repoze.org/>`_ is a 'pay only for what you eat' Python web framework.

`web.py <http://webpy.org/>`_, is a web framework for Python that is as simple sa it is powerful.

`Flask <http://flask.pocoo.org/>`_, web development, one drop at at time.

`TurboGears <http://www.turbogears.org/>`_, The next generation web framework that scales with you.

`Bottle <https://github.com/defnull/bottle/wiki>`_ is a fast and simple micro-framework for small web-applications.

更多 Python Web Framework 查看 `python wiki <http://wiki.python.org/moin/WebFrameworks>`_

