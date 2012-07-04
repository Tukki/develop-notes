public: yes
tags: [javascript, jquery]

==================================
jQuery Attribute Selector Error
==================================

简单记录一个jquery1.7.2在IE上面的错误, 或在说是差异, 备忘.

.. sourcecode:: javascript

   $("[data-toggle='sns_platform'][name='sina_weibo']")


利用 `attribute equals selector <http://api.jquery.com/attribute-equals-selector/>`_ 进行标签选定. 在chrome/FF上面work well. 但后来发现在IE上面不生效. 

当只有一个attribute选择, 能行. 最后没找到合适的错误原因. 直接改在父标签里面选择具体的name来绑定事件. 

现在看来, 原来的html结构就不够高效. 加了太多的重复标签. 或在这样会更好

.. sourcecode:: html

  <div id="sns_platform">
     <span name="sina_weibo">Sina</span>
     <span name="qq_weibo">QQ</span>
  </div>

这样, 再用上"on", 直接:

.. sourcecode:: javascript

   $("[name='qq_weib']", "#sns_platform")


好像跑题了. done
