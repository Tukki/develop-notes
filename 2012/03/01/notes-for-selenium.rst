public: yes
tags: [python, selenium, maybe]

============================
Selenium使用记录
============================

`SeleniumHQ <http://seleniumhq.org/>`_::
  
  Selenium aotumates browsers.

提供了一个控制浏览器的大好方式, 开源免费可编程. 

自动化浏览器操作, 直接查看官方例子 `Getting Started With Selenium-WebDriver <http://seleniumhq.org/docs/03_webdriver.html#getting-started-with-selenium-webdriver>`_

如果要使用Chrome, `得要有chromedriver <http://seleniumhq.org/docs/03_webdriver.html#chrome-driver>`_, `chromedriver官方地址 <http://code.google.com/p/chromedriver/>`_

selenium的WebDriver提供了直接保存screenshot的实现: save_screenshot和get_screenshot_as_file, 还有一个get_screenshot_as_base64::

 Gets the screenshot of the current window as a base64 encoded string
 which is useful in embedded images in HTML.


单是使用selenium, 会看到浏览器控制的全过程. 如果想不被干扰, 可以用到 `xvfb <http://en.wikipedia.org/wiki/Xvfb>`_. python点, 找到 `PyVirtualDisplay <https://github.com/ponty/PyVirtualDisplay>`_

.. sourcecode:: python

  from pyvirtualdisplay import Display
  display = Display(visible=0, size=(1024, 768))
  display.start()
  # .....
  display.stop()

这样, 就能无声无色地控制浏览器了.


拓展开来, selenium可以解决的问题: 1) ajax页面自动登录; 2) 动态页面内容获取; 3) 网站截图

不知道哪些提供网站缩略图的实现, 用的是怎样的技术?


