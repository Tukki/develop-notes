public: yes
tags: [algorithms]

=========================================
about The Hacker News Ranking
=========================================

昨天发现的blog `How Hacker News ranking algorithm works <http://amix.dk/blog/post/19574>`_, 其中提取出来的计算公式如下::

  Score = (P-1) / (T+2)^G

  where,
  P = points of an item (and -1 is to negate submitters vote)
  T = time since submission (in hours)
  G = Gravity, defaults to 1.8 in news.arc

其中随着时间T的增长, Score会越来越低. 而重力G, 则控制了Score衰减速度. 文章中提供了在 `Wolfram Alpha <http://www.wolframalpha.com>`_ (好工具)的具体图示.

补充自己的两个简单模拟.

新Item1获得的Point比旧Item2的Point少. 这里设定P1=30, P2=60, 外加4小时的提取发布. `Query1 <http://goo.gl/y6puH>`_::

  plot(
    (30 - 1) / (t + 2)^1.8, 
    (60 - 1) / (t + 2 + 4)^1.8
  ) where t=0..24

可以看到, 有个交叉点. 在交叉点前部分, Item1得到的Point比Item2少, 但利用时间优势(4小时)可以获得比Item2高的Score. 随着时间的流逝, 优势流失, 最终在一个时间点后分数低于Point高的Item. 

再看一例子, `Query2 <http://goo.gl/Nycfk>`_::

   plot(  
       (1 - 1 + 5 * t) / (t + 2)^1.8,
       (61 - 1) / (t + 2 + b)^1.8
   ) where t=0..24, b=2

新Item的Point以5的速度递增, 当b==2, 交叉点在t约9的地方, 此时大概新Item有45point. 当这个b越大(旧Item发布时间越早), 交叉点越靠前. 利用别人的时间劣势, 即使较少的point也能成为一时的赢家.

在图示中, 看到类抛物线. 对于带时间区间的热榜, 可以考虑利用此算法吧. 热度比不是简单的投票多或者多人购买, 比率(切线?). 有人想知道每日头条, 有人只是想知道"刚刚大家的眼球给了谁", 这样的信息不要等到其爬到顶点才告诉我.

这算法, 纯理论上, 一定程度减轻 `马太效应(Matthew Effect) <http://zh.wikipedia.org/zh/%E9%A9%AC%E5%A4%AA%E6%95%88%E5%BA%94>`_ "多的越多, 少的越少"规则. 联系现实, 只要能获取到位置得到焦点, 就有机会反过来利用马太效应获取到更多的眼球. 营销手段应该也带这类似的思考吧?

不带证明地认为, 此算法受时间影响蛮大的, 新闻类资讯天生带时间属性, 挺对应的. 随时间增长, 新闻不再是新闻. 但也因为这个, 午夜发生的信息如果更新在午夜, 一早就被更多信息覆盖且没被再发现(信息爆炸时代), 就没翻身之地了. 用微博就有此经验, 朋友的信息被其他信息覆盖而丢失.

在Hacker News上面的 `Comments <http://news.ycombinator.com/item?id=1781013>`_ 也有提到这点, `Here <http://news.ycombinator.com/item?id=1781358>`_. 对于全球性的互联网, 的确没有午夜. 但对于区域性的互联网...就应该考虑这个问题了. 在PV少的时段发布的信息是否应该作一个T值修正. 或者, 简单就好.

其实还狠好奇那个重力G是怎样计算, 怎样恒定的. 根据信息的质量调制G值, 对于垃圾/广告信息可以G无限大, 或者直接秒杀. 但对于非特定领域信息, 例如喜好, 一个信息可以让一部人喜欢, 一部分人厌恶, 怎样去恒定此信息质量. 这应该是Reddit在解决的问题, `How Reddit ranking algorithms work <http://amix.dk/blog/post/19588>`_. 

ps.不知道 `Digg <http://digg.com/>`_ 的算法是怎样的? 她的标题就是 "The Lastest News Headlines, Videos and Images".

..
 
   "The best news, videos and picturs on the web as voted on by the Digg community. Breaking news on Technology, Politics, Entertainment, and more!"


在此, 为大学挂科的线性代数好好惭愧下. 

<!-- Mon Nov 28 14:03:15 CST 2011 -->
