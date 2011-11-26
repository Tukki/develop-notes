public: yes
tags: [opensource, ecommerce]
summary: |

======================
开源电子商务系统选择
======================

曾经做电子商务系统时接触过这个选题, 但当时想法已经冲淡了, 而记录也已经七零八落. 现在写个记录作备忘而已

如果你是个PHPer, 好多选择, 自己按照需求去判断哪个适用. 如果用Python(like me before), 跳转 `Python`_

PHP
-----------------

Ray Cheung写了个 `15 Best Free Open Source Ecommerce Platforms <http://www.webappers.com/2010/07/09/15-best-free-open-source-ecommerce-platforms/>`_ 供参考.

然后Paul Anthony提供 `10 kick ass Open source E-commerce platforms reviewed <http://blog.webdistortion.com/2008/05/03/9-kick-ass-open-source-e-commerce-platforms-reviewed/>`_ 说明了部分系统"值得注意的特性"(Notable Features).

国内还有些更具中国特色的, 例如 `ECSHOP <http://www.ecshop.com/>`_

对于这些开源系统的选择, stackoverflow有个问题 `Best PHP/Ruby/Python e-commerce solution <http://stackoverflow.com/questions/76420/best-php-ruby-python-e-commerce-solution>`_, 里面提到了一些经验. 像osCommerce 'is absolute garbage and should not be used under nay circumstances', 但不阻止其 "has attracted a large and growing community that consists of over 254,900 store owners, developers, service providers, and enthusiasts who support and work with each other on their online business."

试用吧. 他们一般都有提供个demo页来吸引你的眼球. 

然后思考: 你的需求是什么? 他们提供的特性是否直接满足你? 如果有点不满意, 是你迁就他们的实现, 还是下载其源码看看里面的实现, 衡量二次开发成本大不大? 

如果想自己写, 网上教程不少. `Google之 <http://www.google.com/search?q=php+shop+tutorial&ie=utf-8&oe=utf-8&aq=t&rls=org.mozilla:en-US:official&client=firefox-a#sclient=psy-ab&hl=en&client=firefox-a&hs=HDZ&rls=org.mozilla:en-US%3Aofficial&source=hp&q=php+shopping+tutorial&pbx=1&oq=php+shopping+tutorial&aq=f&aqi=&aql=&gs_sm=e&gs_upl=25276l26102l0l26325l4l4l0l0l0l2l410l1046l3-2.1l3l0&bav=on.2,or.r_gc.r_pw.,cf.osb&fp=eb56d7d37a8e78ab&biw=1525&bih=726>`_, PHP强大啊. 像这个 `PHP MySQL Shopping Cart Tutorial <http://www.phpwebcommerce.com/>`_, 印象中简单易懂是个好教程.

ps. 看国内 `新蛋 <http://www.newegg.com.cn/>`_, `京东 <http://www.360buy.com/>`_, `苏宁 <http://www.suning.com/>`_, `国美 <http://www.gome.com.cn/>`_ 几个商城的风格, 真有点认为他们都在用同一个系统.


Python
-----------------

相对来说, Python Based的选择真的少可怜. `Python base eCommerce System technical comparisoon <http://valentinewebsystems.com/en/blog/ecommerce-comparison>`_, 里面提到GetPaid, EasyShop, `LFS <http://www.getlfs.com/>`_, `Satchmo <http://www.satchmoproject.com/>`_, 四个, 没了. 或者还有别的没提.

LFS, Satchmo接触过, 但没有真正去用. 两个都是基于django.

可能是为了通用, 自己认为LFS的实现其实蛮大的. 像LFS的Product Model, 就包含了base info, stocks, dimension, variants, price calculation, manufacturer. 导致要抽取自己所需, 不全局考虑的话会有点难度.

而stachmo的可配性相对较高, 不少实现都是放在对应app的modules里面, 可以在"INSTALLED_APPS"里面选择使用. 也提供个ext实现, 比LFS的结构清晰.

外加一大堆开源App和工具, 还有个 `Pinax <http://pinaxproject.com>`_, 用django写个电子商务系统其实也不是太麻烦的事. 预期不可避免的会遇到里面的实现如果涉及到用户, 必然是用了django内置的auth. 

果然没有银弹. 


<!-- Sat Nov 26 18:06:47 CST 2011 -->

