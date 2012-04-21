public: yes
tags: [css, less, javascript]

Start Using Less
======================

`less <http://lesscss.org/>`_, The dynamic stylesheet language.

作为一个不专一的Web程序员, 不得不为css头痛一下. css没什么错, 只是自己的不专业, 对维护css和在原有css上面追加新东西有点不自在而已. 

"这个页面想要原来另外一个页面的按钮的效果, 不过颜色稍稍作点改动". 

好吧, 用firebug找到按钮具体在哪一行的css, 发现在"#xx .yy ul li span a"上面, 好吧. 认了, 然后copy一份过来. 这种情况, 应该是"css一开始就没抽象好, 以后也没整理过, 那就只能继续乱下去的感觉."

换个好一点的抽象. 需要buttom? 'class="btn gray width100"'. 组合强大. jqueryUI应该是这样做的. 维护这一份抽象, 得化点功夫.

跑题了. 借口了. 自己还没认真体会到前端写css时的乐趣, 只是自己爱折腾罢了.

知道less是因为 `twitter/bootstrap <https://github.com/twitter/bootstrap>`_, 不过bootstrap还没开始, 先开始less了.

variables, operations and functions这些功能的好处在自己这边还没体验出来, 不过Nested Rules, Mixins倒是狠喜欢的说.

Nested Rules帮忙避免了写css不断低copy一行父关系来增加子效果. 外加 "&" 的使用, 如虎添翼. 写起来舒服.

Mixins避免了在css的class组合. 虽然我说不出这样的class组合有什么不好, 不过可以的话, 我宁愿在html的dom上面, 只是标注了一个class名词.

用less.js调试样式, 再用lessc生成具体的css用户生产环境. 在无法避免的前端开放中尝试点新的模式

这一次, 又得感谢google v8了.

爱折腾, 只是为了更好的开发速度和更好的可维护性. 持续学习中

<Sun Apr 22 00:23:43 CST 2012>


