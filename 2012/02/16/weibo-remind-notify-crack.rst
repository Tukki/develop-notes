public: yes
tags: [weibo]

=========================================
Weibo Remind Notify Crack
=========================================

新浪微博开放平台提供的这个接口 `remind/unread_count <http://open.weibo.com/wiki/2/remind/unread_count>`_, 存在应用漏洞, 利用此漏洞可以获取到未进行应用授权的其他用户的提醒信息.

只需要在浏览器上面登录指定某app下的授权用户, 然后另外开一个页面, 设定前app的key和目标用户id, 用JSONP调用此接口, 即可获取目标提醒信息.

获取到这些信息有什么用? 分析用户使用微博的时间习惯, 当然从写微博的时间上也能进行这方面的分析, 但个人相信读时间更准确. 下面是新浪某高管的今天获取到的数据.

========      ======    ========      ====    ====    ========   ========   =====   ======  ======  =====   ========
time	      status	follower      cmt     dm      mcmt    	 mstatus    group   notice  invite  badge   photo
========      ======    ========      ====    ====    ========   ========   =====   ======  ======  =====   ========
18:26:56      18        0             2	      0	      0	       	  0         0       0	    0	    0 	    0
18:21:56      38	0	      1       0	      0		  0	    0	    0	    0	    0	    0
18:16:40      3         0	      10      0	      0	          0	    0	    0 	    0	    0	    0
18:12:29      28	0	      9	      0	      0		  0	    0	    0	    0	    0	    0
18:12:28      28	0	      9	      0	      0	 	  0	    0	    0	    0	    0	    0
18:11:56      24	0	      8	      0	      0		  0	    0	    0	    0	    0	    0
18:10:05      5	     	0	      7	      0	      0		  0	    0	    0	    0	    0	    0
18:06:56      18	0	      7	      0	      0		  0	    0	    0	    0	    0	    0
18:01:56      0	     	0	      5	      1	      0		  0	    0	    0	    0	    0	    0
17:56:56      0	     	0 	      5	      0	      0		  0	    0	    0	    0	    0	    0
17:56:02      0	     	0	      5	      0	      0		  0	    0	    0	    0	    0	    0
17:41:56      467	0	      5	      0	      0		  0	    0	    0	    0	    0	    0
17:36:56      415	0	      5	      0	      0		  0	    0	    0	    0	    0	    0
========      ======	========      ====    ====    ========   ========   =====   ======  ======  =====   ========

可以看出其17:42分后的, 开始读微博(status, 467->0), 而对于评论(cmt), 其到了18:16分后才处理. 

当然, 这些数据也暴露了该用户的设定可能. mcmt, mstatus分别对应"新提及我的评论数", "新提及我的微博数". 在小数据面前, 显示该用户是忽略了这方面的信息提醒, 不过事实是怎样, 可以通过测试获得. 不过这是个人私隐, 还是得尊重下的, 名人也是需要隐私的.

两个有趣的发现, 互联网某偶像级别的大佬, 明显是取消了所有的提醒(新微博提醒不能取消吧). 看来想 @ 一下此名人是需要点额外技巧了. 而另外一大哥, 所有提醒全开, 真的时兢兢业业, 对得起新粉丝数持续上升.

某君在下班后泡微博大半个钟..按时间长度来看, 猜测在坐车回家吧.

开放的网络需要更多的安全方面的技术支持. 我这一次, 邪恶了.

<Thu Feb 16 18:53:54 CST 2012>

示例文件: `weibo_remind_crackr.html <https://github.com/Tukki/codesnippet/blob/master/javascript/weibo_remind_crackr.html>`_

<Thu Feb 16 23:14:33 CST 2012>

.. role:: strike
   :class: strike

:strike:`update: 这个隐私泄漏问题修正了.`

:strike:`<Sat Feb 25 00:33:04 CST 2012>`

问题依旧. 不知道该如何反映此问题. 或在这隐私没那么重要?

<Sat Mar  3 15:09:41 CST 2012>

