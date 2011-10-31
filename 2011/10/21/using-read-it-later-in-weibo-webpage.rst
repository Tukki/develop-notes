public: yes
tags: [jQuery, itch]

===================================
在新浪微博网页添加ReadItLater功能
===================================

.. role:: strike
    :class: strike

About `Read it later <http://readitlaterlist.com/>`_, bookmarking service, one of the GTD tools.

关于 `新浪微博 <http://weibo.com>`_, 呃, 的确是一个不错的获取资讯的平台, 获取各种各样的自己感兴趣的资讯.

总有些Weibo想稍候再读的, 例如有些音乐, 有些链接.  :strike:`现阶段利用 ReadItLater的Add Links方法,` 自己做了个书签工具作简单的注入实现. 又因为懒得每次点击书签栏, 追加了FireFox Greasemonkey和Chrome Extensions实现, 源码放在了 `github <https://github.com/Tukki/codesnippet/tree/master/javascript/Weibo-RIL>`_

效果图:

.. image:: /static/2011-10/read-weibo-later.png


-------------
使用方法
-------------

1. 如果使用书签栏工具的话, 自己创建书签, 将 `js文件 <https://raw.github.com/Tukki/codesnippet/master/javascript/Weibo-RIL/for_bookmark_tool.min.js>`_ 的内容复制一份作为书签的网址/位置保存.

2. 如果使用firefox, 可以在 `UserScript <http://userscripts.org/scripts/show/116025>`_ 安装, 不过先得有插件 `Greasemonkey <https://addons.mozilla.org/en-US/firefox/addon/greasemonkey/>`_.

3. 如何使用的是chrome, 可以直接下载 `chrome extension打包文件 <https://github.com/Tukki/codesnippet/blob/master/javascript/Weibo-RIL/read-weibo-later.crx>`_ 安装. 不准备添加到Chrome Webstore.



以下内容是开放时的一些笔记. 

--------------------------
Read It Later button
--------------------------

| 官方介绍: http://readitlaterlist.com/api/buttons/  
| 其重点在其js实现上面. http://readitlaterlist.com/button/multi_v1.js

通过插入<iframe>获取按钮, 没有用到ajax操作. 而先前尝试用jQuery的异步调用其提供的API, 返回结果的确是'200ok', 但确实错误返回, 一直没找出原因.

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


