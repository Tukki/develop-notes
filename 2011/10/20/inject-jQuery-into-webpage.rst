public: yes
tag: [jQuery]

========================
往网页注入jQuery
========================

今天"Scatch my own itch", 想为微博添加个直接的"Read It Later"功能. 利用书签栏直接运行javascript的方法应该来的通用简单点, 在实现的过程中, 就遇到了这个"Inject"单词.

在书签栏直接运行javascript, 只不过时网址部分更改为javascript, 注意不要带"//"注释. 示例如下:
.. sourcecode:: javascript
  
   javascript: (function(){alert('ok');})()


因为要继续Dom操作, 而自己较熟悉的是jQuery, 必然要想办法获取jQuery. 而又要确保jQuery加载成功, 就优先想到了利用Google API的 `Loader <http://code.google.com/apis/loader/>`_. (知道其存在, 但一致没用过)

参考其文档上*Dynamic Loading*的示例改写:

.. sourcecode:: javascript

   function jqueryLoaded(){}
   
   function loadJQuery(){
      google.load('jquery', '1.6.4', {'callback': jqueryLoaded}); 
   }
   
   function initLoader(){
      var script = document.createElement('script');
      script.src = 'https://www.google.com/jsapi?key=MYKEY&callback=loadJQuery'
      script.type = 'text/javascript';
      document.getElementsByTagName('head')[0].appendChild(script);
   }


构建书签, 测试::

   Module: 'jquery' must be loaded before DOM onLoad!

改用" google.setOnLoadCallback()也不行. 如果直接在网页上测试, 通过. 最后在StackOver找到 `Injecting jQuery into a page fails when using Google AJAX Libraries API <http://stackoverflow.com/questions/840240/injecting-jquery-into-a-page-fails-when-using-google-ajax-libraries-api>`_, 脱离Google Loader, 直接利用"onlooad, onreadystatechange"事件执行回调.

.. sourcecode:: javascript

   (function() {
        var script = document.createElement("script");
	script.src = "http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js";
    	script.onload = script.onreadystatechange = function(){ /* your callback here */ };
    	document.body.appendChild( script );
    })()

里面的comment也提到 `ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js <http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js>`_ 能获取到jQuery的最新版本

最后修改的加载实现为:

.. sourcecode:: javascript

     function loadJQuery(cbFunc){
        if(!window.jQuery){
	    var script = document.createElement('script');
	    script.src = "http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js";
	    script.type = 'text/javascript';
	    script.onload = script.onreadystatechange = cbFunc;	
	    document.getElementsByTagName('head')[0].appendChild(script);
	}else{
	    cbFunc();
	}
     };
   

至于用Google Loader的方法, 未找到修正实现

(Thu Oct 20 22:48:30 CST 2011)
