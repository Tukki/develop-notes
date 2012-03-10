public: yes
tags: [python]
summary: |
   Python字典排序引起的记录

Python Dict Sort
===========================

Sort a dictionary by key or value
----------------------------------

checkout `stackoverflow <http://stackoverflow.com/questions/613183/python-sort-a-dictionary-by-value>`_

里面的例子如果改用lambda的话(不知道性能是否有很大的差别...)

.. sourcecode:: python

   import operator
   x = {1:2, 3:4, 4:3, 2:1, 0:0}
   sorted_x = sorted(x.iteritems(), key=lambda x: x[1])  # by value

联系昨晚遇到的场景, dict的value是列表. 按value长度排序一下. 我用了个笨方法, 再开一个列表记录value的长度与key的对应值, 再枚举输出. 其实可以更pythonic点:

.. sourcecode:: python

   sorted_x = sorted(d.iteritems(), key=lambda x: len(x[1]))

这里也额外记录一下, 在python里面list的比较, 是按对应位移比较的. 相等则下一位. 


Ordered Dict
---------------

python的dict内部是无序的. 如果想要有序的dict?

Python2.7的collections有 `OrderedDict <http://docs.python.org/library/collections.html?highlight=ordereddict#collections.OrderedDict>`_. 

对于Python2.4-2.6, 有 `pypi ordereddict <http://pypi.python.org/pypi/ordereddict>`_, *A drop-in substitute for Py2.7's new collections.OrderedDict* .

Django的比较有爱, 内置了一个SortedDict实现, 在utils.datastructures里面.

简单看了看代码实现, Django的实现是"继承dict, 然后在内部维护一个key列表". 而ordereddict的, 有一个 __map[key] = [link_prev, link_next, key]. 是直接链表维护, 减少key order的变动成本. 

原来某君说的用list来维护顺序低效的出处在这里. 受用了.

<Sat Mar 10 18:14:54 CST 2012>



