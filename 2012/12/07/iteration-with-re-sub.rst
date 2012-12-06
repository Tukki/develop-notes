public: yes
tag: [python, tips]

===========================
Iteration within re.sub()
===========================

今天有个re.sub()相关实现需要在替换字符串的时候附加位移信息进去, 用来标识其是第几次出现. 

查文档函数不支持!  全局变量统计当然可以, 比较丑陋. 想到了闭包, 在函数里面定义函数以访问外层函数的变量, JS的话应该时可以的, 只是python的闭包好像不是这样的, 什么地方理解错了. 

还是Google给力, 问题不是新的. 找到同样的需求. `http://bytes.com/topic/python/answers/39307-iteration-within-sub`

构建类, 用类方法提供给sub作为替换行数... first class? 基础概念都忘了... 

摘录代码片段

.. sourcecode:: python

   #!python
   import re
   
   class Counter(object):
       def __init__(self):
           self.count = 0
   
       def increment(self, match_object):
           repl = str(self.count)
           self.count += 1
           return repl
   
   text = 'abbabababbbbbaaa'
   expected  = 'a01a2a3a45678aaa'
  
   c = Counter()
   ptn = re.compile(r'(b)')
   actual = ptn.sub(c.increment, text)
   assert expected == actual

