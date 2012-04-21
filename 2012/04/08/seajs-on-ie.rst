public: yes
tags: [javascript, bug]

SeaJS on IE
==================

上周五在SeaJS的使用上遇到问题, 在IE上面报错, 加载不了easyXDM. 在Chrome/Firefox上面都无误, 到IE上面就理所当然地抛出了错误.

IE的错误信息害死人.. "Rpc为Null或不是对象", 还真以为是Rpc出了问题, 经提醒打印信息处理, 才发现easyXDM已经为Null. 加载失败? 尝试用spm把其打包到init.js里面, 结果还是不行.

倒是, 如果设置为"始终从浏览器更新", 倒是问题解决. -- 我当时有点放弃, 不如把这个init.js或在easyXDM一直过期不缓存处理算了 -- 解决方法不知一个, 把easyXDM放回全局加载, 问题一样能解决. 现上线吧, 这样的改动还是能暂时接受的.

把问题反馈给SJ, 他折腾(?)了好一会, 下午给了个答案我, "大小写问题". 把easyXDM的module dentifier用小写处理, 问题解决. 

`Module Identifiers <http://wiki.commonjs.org/wiki/Modules/1.1.1#Module_Identifiers>`_ 里面只是提到::
  
  A term must be a camelCase identifier, ".", or "..".

没说一定要小写阿. camelCase? 突然想"easyXdm"会不会也行得通? 明天会公司的时候测试一下.

如果真如猜测, 看来不是SeaJS的问题, 是自己对标准的理解问题. 

<Sun Apr  8 23:39:01 CST 2012>


尝试过了, easyXdm能行. 不过, 当时顺带再测试了下easyXDM. 也行. 不带这样完的吧. 所以, 测试不带代表性, 无法证明什么.

<Sat Apr 21 23:41:14 CST 2012>

