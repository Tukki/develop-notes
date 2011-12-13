public: yes
tags: [technique, thoughts]

=================================
利用CDN加速即时视频
=================================

不知道冲哪里突然有这个想法的: 静态内容(文本/图片/视频)可以利用CDN进行加速, 那动态内容可以不?

实时的多人视频, 其中的stream, 也需要用网络上的数据包来传递. 把这个数据包看成是粒度小的静态文件, 那CDN不久可以对其进行加速了, 只不过其寿命比一般静态文件短而已. (当然也可以缓存下来, 作为视频下载用, 意义不大.)

然后今晚和Jim聊起, 决定Google下, 发现这做法是存在的. Amazon的aws就有相关的文章.

`Adobe and Amazon Web Services <http://aws.amazon.com/solutions/global-solution-providers/adobe/>`_, 里面提到支持 HTTP Dynamic Streaming, RTMP, RTMFP. 

看其 `价格 <http://www.adobe.com/products/flashmediaserver/amazonwebservices/>`_, 不是这个领域的, 也不知道贵不贵.

Amazon的基础服务果然强大. 

<!-- Tue Dec 13 22:40:27 CST 2011 -->
