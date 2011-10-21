public: yes
tag: [jQuery, itch]

===================================
在新浪微博网页添加ReadItLater功能
===================================

About `Read it later <http://readitlaterlist.com/>`_, bookmarking service, one of the GTD tools.

关于 `新浪微博 <http://weibo.com>`_, 呃, 的确是一个不错的获取资讯的平台, 获取各种各样的自己感兴趣的资讯.

总有些Weibo想然后再细读的, 现阶段利用 ReadItLater的 `Add link <http://readitlaterlist.com/api/adding/>`_ 方法, 做了个简单的注入实现. 又因为懒得每次点击书签栏, 追加了FireFox Greasemonkey和Chrome Extensions实现, 源码放在了 `github <https://github.com/Tukki/codesnippet/tree/master/javascript/Weibo-RIL>`_


.. raw:: html
   
   <script type="text/javascript">

   </script>


----------------------
detect dom changed
----------------------

要在ajax追加新微博后再次执行自定义的追加函数, 可以用 `DOMNodeInserted event <http://help.dottoro.com/ljmcxjla.php>`_, 自己的实现中用了简单的锁, 对于发生连续的事件时, 减少追加函数的执行次数

.. sourcecode:: javascript
   
   var hassetup = false;
   function detect_changed(id, cbFunc){
        document.getElementById(id).addEventListener('DOMNodeInserted', function(){
	   if (!hassetup) {
	      window.setTimeout(function(){
	          cbFunc();
		  hassetup = false;
	      }, 2000);
	      hassetup = true;
	   }
	})
   }


--------------------
Greasemonkey notes
--------------------

在Greasemonkey中使用jQuery, 可以使用其 `@require <http://wiki.greasespot.net/Metadata_Block#.40require>`_, `wiki <http://wiki.greasespot.net/Third-Party_Libraries>`_ 里面有介绍. 或在参看 `这里 <http://joanpiedra.com/jquery/greasemonkey/>`_ 的实现, 用unsafeWindow来获取jQuery的引用. 先前提到的利用书签直接注入jQuery的方法在Greasemonkey不适用, 应该是 `Sandbox <http://wiki.greasespot.net/Sandbox>`_ 的问题. 

用*@require*有个优势时在userscript安装的时候, 回下载目标js缓存下来, 以后就不必每次都网络加载.



-----------------------------
chrome extensions notes
-----------------------------

要在chrome extensions中加载jQuery或在其他第三方实现, 可以利用其 `Content Scripts <http://code.google.com/chrome/extensions/content_scripts.html>`_::

   Content scripts are JavaScript files that run in the context of web pages.

其实UserScript可以直接作为Chrome的扩展进行用, `官方文档 <http://www.chromium.org/developers/design-documents/user-scripts>`_, 但不支持*@require*的解析, 要自己下载并确定顺序::
 
   content_scripts::js, The list of JavaScript files to be injected into matching pages.
   These are injected in the order they appear in this array.

