public: yes
tags: [html5, javascript]
summary: |
  记录初次折腾html5上canvas, websocket时遇到的东西

============================================
Notes for HTML5 canvas and WebScoket
============================================

the useful websites
----------------------

`WebSocket Echo Test <http://websocket.org/echo.html>`_, 可以知道当前使用的浏览器是否支持WebSocket.

`When Can I use... <http://caniuse.com>`_

  Compatibility tables for support of HTML5, CSS3, SVG,
  and more in desktop and mobile browser.

可以查询到canvas, websocket等(其他全部)在各浏览器的支持程度, 应该属于HTML5开放必备收藏之一

对于canvas, IE9之前是不支持的, 当可以用Google的 `explorercanvas <http://code.google.com/p/explorercanvas/>`_ hack一下, 来提供相关的实现.

.. sourcecode:: html

     <!--
   Load Canvas support for IE8. ExplorerCanvas courtesy Google. 
   See: http://code.google.com/p/explorercanvas/
   -->
   <!--[if lt IE 9]>
    <script src="excanvas.js"></script>
   <![endif]-->

`MDN Canvas tutorial <https://developer.mozilla.org/en/Canvas_tutorial>`_, canvas入门上品. 

而unionplatform有个协同画板的展示页 `Multiuser Drawing Pad <http://www.unionplatform.com/?page_id=2762>`_, 里面可以下载源码看看画板如何绑定鼠标/touch事件的. 有必要看看此源码, 里面说明了不少事件的使用事项.

XMPP, CometD, WebSocket, all about the realtime apps. 现在Websocket的浏览器支持度并不高(`Here <http://caniuse.com/#feat=websockets>`_), 现在找到的one-for-all方法为 `Socket.io <http://socket.io>`_, 唯一问题在于其是前后端一体化实现, Javasript, Node.js


some implememnt details
------------------------

在touch devices上面需要的meta信息. ps. ship from oribitermicro_uniondraw. thanks!

::
  
  <!-- Prevents iPhone, IPad, and touch devices from scrolling or zooming when touched -->
  <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0" />

鼠标事件有: canvas.onmousedown, document.onmousemove, docuemtn.onmouseup

触摸屏事件有: document.ontouchstart, document.ontouchmove, docuement.ontouchend

鼠标与触摸屏兼容判断? 如何document有 *ontouchstart* 事件就不用注册鼠标相关的事件了. ps. 没有查是不是标准.

清空画板的实现

.. sourcecode:: javascritp
   
   //context.fillStyle = "#ffffff";
   //context.fillRect(0, 0, canvas.width, canvas.height); 
   // 找到的实现细节有上面两句.说是针对chrome的. 但自己使用时只要下面一句就满足效果了?
   canvas.width = canvas.width;

