public: yes
tags: [javascipt, seajs]
summary: |
   以下纯属记录, 未经严格验证, 不应推广

Seajs Anti-pattern
==========================

以下纯属记录, 未经严格验证, 不应推广!!

非独立文件module
------------------

seajs的 `Module Definition <http://seajs.org/docs/module-definition.html#module-definition>`_::
  
   In SeaJS, any JavaScript file should be written in module format,
   and files and modules are in one-to-one correspondence.

但查看spm build 出来的文件, 其依旧遵从下面的模式, 只是, id是带域名/链接的构成.
  
  define(id?, dependencies?, factory);

所以, 可以在非独立js文件里面定义module, 像requirejs一样, 指定id和dependencies. 不过猜想, 在path中需要另外指定对应id的路径, 至于是不是必需, 待验证


require nature javascript lib
-------------------------------

不可否认Requirejs的作者 `James Burke <https://github.com/jrburke>`_ 的魅力, 说服jquery把AMD加到了代码是实默认支持中. 而在seajs, 要做到:

.. sourcecode:: javscript

  var $ = require('jquery');

还需要额外对jquery源码进行一个封装. 其实, 自己还是蛮喜欢 write javascript the javascript way. 懒得对一个现成lib都进行一次封装. 将seajs这部分当成简单的包依赖管理来用, 直接 require('jquery'), 让其回归全局. 再直接用$来调用, 也是可行的.

不过, 按seajs的设计来看, 属于坏习惯. 


<Tue May  1 01:34:37 CST 2012>
