public: yes
tags: [algorithms]

=======================================
Notes on the Reddit ranking algorithms
=======================================

`How Reddit ranking algorithms work <http://amix.dk/blog/post/19588>`_
  
Conslusion of Reddit's story ranking

- Submission time is a very important parameter, generally newer stories will rank higher than older

  都是时间相关, 但Reddit的不会像Hacker News一样其分数值随时间减少, 在提交那一刻, 已经明确了这个常数. 但后面提交的Item, 这个常数会比前面的大, 这个感觉多少有点不公平.

- The first 10 upvotes count as high as the next 100. E.g. a story that has 10 upvotes and a story that has 50 upvotes will have a similar ranking

  越早进行upvote的人对于分数值的贡献越大, 后面upvote的发生可能就是因为这前十个的功劳. 
  
- Controversial stories that get similar amounts of upvotes and downvotes will get a low ranking compared to stories that mainly get upvotes 

  {1000upvote, 900downvote}和{100upvote, 0downvote}, 在忽略提交时间下得到的结果是一样的.  如果后者的提交时间稍微迟点, 位置就会比前者高. 但看上去, 前者更有争议性, 吸引用户参与.


最热和最好不能同时兼得. 于是有了Reddit评论系统排序的"Best"实现 `reddit's new comment sorting system <http://blog.reddit.com/2009/10/reddits-new-comment-sorting-system.html>`_.  Confidence Sort, 信心排序?

`Reddit’s comment ranking algorithm <http://possiblywrong.wordpress.com/2011/06/05/reddits-comment-ranking-algorithm/>`_ 对其实现指出原代码实现的与算法上的不一致. (已经修正了两个)


拓展出来的两个阅读:

`Reddit, Stumbleupon, Del.icio.us and Hacker News Algorithms Exposed! <http://www.seomoz.org/blog/reddit-stumbleupon-delicious-and-hacker-news-algorithms-exposed>`_

  里面提到Del.icio.us的Popular是最近1小时收藏最多的网址. Digg.com的没详细说, 不过提到的期望很带社交性. 一个"威望值"高的人提交的信息是否比一个新手"发现"的信息中带的价值更大?

`How to Build a Popularity Algorithm You can be Proud of <http://blog.linkibol.com/2010/05/07/how-to-build-a-popularity-algorithm-you-can-be-proud-of/>`_

 里面是 `linkibol <http://linkibol.com>`_, web2.0 social bookmarking 实现者写的记录


<!-- Thu Dec  1 22:42:54 CST 2011 -->
