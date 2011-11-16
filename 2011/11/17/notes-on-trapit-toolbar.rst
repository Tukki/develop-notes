public: yes
tags: [html, error]

==============================
对trapit-toolbar进行模拟的记录
==============================

对 `Trap It <http://trap.it>`_ 里面的toolbar实现猜想现在证明是冲动的结果. 

原认为用的是javascript injection, 后台加载目标网站后添加自己想要的javascript进去. 自己还去找了找有没有哪个实现能在后台加载渲染整个网页, 包括javascript和css. 只是没有或在没找到, `mechanize <http://wwwsearch.sourceforge.net/mechanize/>`_ 也不支持javascript, 甚至相关chrome有无命令行版本的... 回头冷静想想, 用Firebug一看. 是直接打开目标网站的, 才想起iframe能实现这内嵌效果. 简单不冲突.

用tornado写了个demo, (本来想用pyramid, 不过感觉不够micro, 用mako还得配置). 根据传递的"url"更改iframe的src值. 本来应该就这样结束的. 点击iframe里面的链接, 才发现iframe的src值和浏览器地址栏都不会随着更新(Trapit的因为是一大串数字没在意), 而且浏览器的前后导航变动针对的是iframe里面的切换.

然后就是, javascript无法获取iframe里面的内容. `Stackoverflow <http://stackoverflow.com/questions/364952/jquery-javascript-accessing-contents-of-an-iframe>`_ 有个相关的问题, 然后重点在Wikipedia的 `Same origin policy <http://en.wikipedia.org/wiki/Same_origin_policy>`_ 上面. 里面提到"Same protocol and host but different port"都属于限制的, 但这里就有个TODO新添加了: 为什么同一ip地址不同端口的两个实现, 能共享cookie? 

<!-- Thu Nov 17 01:50:28 CST 2011 -->



