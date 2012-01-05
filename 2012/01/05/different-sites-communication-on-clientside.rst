public: yes
tags: [unfinished, javascript, webdev]

客户端不同网站间交互实现记录
========================================

起个名字真难. 没有标题说的那么大而全, 只是记录下简单自己在2011后半年遇见的几个交互实现.


JavaScript生成链接
-----------------------------

Delicious, weibo的分享按钮.

这一类是最常见的. JavaScript获取需要的信息, 构建链接, 用window.open打开新窗口. 


服务器生成iframe
---------------------------

`ReadItLater Button <http://readitlaterlist.com/api/buttons>`_

JavaScript生成一iframe插入当前页面, 把需要保持的信息放在iframe上src的链接参数中, 让RIL服务器根据参数值动态生成交互按钮返回作为iframe的内容. 因为使用的是iframe, RIL可以判断用户是否处于登陆状态(根据cookie), 去决定返回让用户点击的时候跳转登陆的按钮, 还是直接POST进行保存内容的按钮, 还是提示用户当前页面处于"已记录"状态. 在生成iframe的一刻已经决定了交换的内容, 尔后进行交换时互不干涉.


JavaScript生成iframe
-------------------------

`Instapaper <http://www.instapaper.com>`_

Instapaper的"Read Later"按钮, 也是生成iframe. 不过iframe里面需要交换的内容, 是本地js设定的. 服务器返回了iframe的内容模板字符串, 本地js获取需要的值根据模板生成目标内容, 由本地js直接写不带src的iframe. 


HTML5
--------

`HTML5 window.postMessage <https://developer.mozilla.org/en/DOM/window.postMessage>`_::
 
  window.postMessage is a method for safely enabling cross-origin communication.

没实际去应用过, 这个算是HTML5提供的官方解决方案了. 


Flash
-----------

Diigo, WebNotes提供嵌入当前页面的工具条. 没有认真拆解过, 但确认其没用到Html5特性. 而且两个都属于有后续有不确定交互发生的存在, 由于iframe设定是"上下文无关". 那猜想应该是用了flash. `Using the External API for Flash-JavaScript Communication <http://www.adobe.com/devnet/flash/articles/external_interface.html>`_


<!-- Thu Jan  5 15:31:24 CST 2012 -->
