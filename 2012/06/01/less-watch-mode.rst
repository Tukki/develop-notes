public: yes
tags: [css, javascript, less]

==============================
Less watch mode
==============================


`Less <http://lesscss.org/>`_ 里面提到的watch mode一直没能用上(在开发域名上面运行), 也没去找那里出错了. 忙乎阿. 刚才再Google了下, 找到了解决方式. 


github上面提到个 `pull request #679 <https://github.com/cloudhead/less.js/pull/679>`_, 不过还处于open状态, 修改了源码. 解决方式一. 

然后, `Less.js in development and watch mode <http://www.paulsprangers.com/2011/04/quick-tip-less-js-in-development-and-watch-mode/>`_. 原文提到的方式不靠谱, 反而评论提到了两个方式, 一个是修改源码, 等于把自己的开放域名注册到Less.js文件里面. 另外一个, Force init value of less.env var::

  // Force init value of less.env var
  var less = { env: ‘development’ };
  // Less itself

  // Watch
  less.watch();

需要在加载Less.js之前初始化env变量, 不如在非本地测试环境, 加载Less.js后判断 env 是否为 *development* 而选择了不同的模式. 再手动watch也不能生效.

ps. 可以用 less.poll 来控制watch频率


<!-- Fri Jun  1 00:43:06 CST 2012 -->
