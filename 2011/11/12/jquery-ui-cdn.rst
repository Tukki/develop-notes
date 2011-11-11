public: yes
tags: [jQuery]

================================================
jQueryUI on Google CDN
================================================

jQueryUI在Google CDN的 `文档 <http://code.google.com/apis/libraries/devguide.html#jqueryUI>`_ 没有说明其CSS在哪里. 找了找, 发现其实是存在的. 只不过按网上的说法, 就是undocumented feature.

找到的两个有用链接:

1. `Do you know about this undocumented Google CDN feature? <http://encosia.com/do-you-know-about-this-undocumented-google-cdn-feature/>`_
2. `Latest jQuery and jQuery UI Theme links on Google CDN <http://www.devcurry.com/2010/05/latest-jquery-and-jquery-ui-theme-links.html>`_


copy个示例链接过来::

  https://ajax.googleapis.com/ajax/libs/jquery/1.7.0/jquery.min.js
  https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.js
  http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.10/themes/ui-darkness/jquery-ui.css

结构分明. 要换具体版本就更改链接里面的版本号. jQueryUI更改主题就替换链接中themes后面的主题名


