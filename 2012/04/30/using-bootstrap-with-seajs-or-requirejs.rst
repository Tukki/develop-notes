public: yes
tags: [javascript, seajs]

Using Bootstrap with Seajs or Requirejs
=========================================

`Bootstrap <http://twitter.github.com/bootstrap/>`_ 提供了常用的jQuery plugins. 虽然可以打包一次全部使用也不见得很大, 但如果真想按需使用, 就用到了 `Module Loader <http://wiki.commonjs.org/wiki/Modules>`_. seajs和requirejs在我这还处于对比阶段, 所以, 颇显麻烦地对比使用了一次.

首先给出简单的modal的初始化实现. ps. bootstrap的js代码和jquery放在同一个目录下面

.. sourcecode:: javascript

   define('foo', ['jquery', 'bootstrap-modal'], function(){
         var init = function() {
	     console.log('start init modal');
	     $("#lanchModal").click(function(){
	        $("#myModal").modal('toggle');
	     });
	 return {'init': init}
   })

这个定义方式, 是requrejs里面默认支持; 其实, seajs虽然没显示说明, 但还是支持的(`Module Definition <http://seajs.org/docs/module-definition.html#module-definition>`_)::

   ** NOTICE: It is highly recommended to ignore the id and dependencies arguments in the define statement. 
   The optimization tool will generate these arguments automatically in the deployment phase.


"The sea, holding water from thousands of rivers, is huge owing to its capacity.", 如果说seajs不支持此方式, 感觉就对不起这样的定义了.


seajs的配置/调用代码:

.. sourcecode:: javascript

   // require sea.js or sea-debug.js
   seajs.config({
       base: './path/to/lib', 
       })
   seajs.use(['foo'], function(foo){
       console.log('start calling foo using seajs');
       foo.init();
       })
       
把requirejs的实现也先摆上来:

.. sourcecode:: javascript

   // require require.js
   require.config({
       baseUrl: './bootstrap/js',
       });
   require(['foo'], function(foo){
       console.log('start calling foo using requirejs');
       foo.init();
   })


因为是最后的实验结果, 导致已经看不出seajs和requirejs的不同了. seajs推荐的方式是把module放到一个独立的文件里面, 采用 define(function(require, export, module){}) 的 `Modules/Wrappings <http://wiki.commonjs.org/wiki/Modules/Wrappings>`_ 模式. 

这里不对比seajs和requirejs. 只是有一点可以确认的, seajs依旧可以把modules定义到同一个文件里面,  现在没考虑spm进来, 所以也不确认是否会引起什么问题. 此问题再追究.

现在, 依旧可以用seajs来管理实现对bootstrap的js的依赖, 按需索取. 

整个demo页面记录在了github, `bootstrap with seajs <https://github.com/Tukki/codesnippet/blob/master/javascript/bootstrap-with-seajs.html>`_

<Tue May  1 01:05:54 CST 2012>

