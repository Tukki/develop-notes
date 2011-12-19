public: yes
tags: [database, knowledge]

====================================
Hierarchecal Data on Database
====================================


`MPTT <http://imrannazar.com/Modified-Preorder-Tree-Traversal>`_, modified pre-order tree trasversal

`Materialized Path <http://en.wikipedia.org/wiki/Materialized_path>`_, a technique for encoding a tree in a flat data structure.

`django-mptt <https://github.com/django-mptt/django-mptt/>`_, MPTT for Django

`sqlamp <http://sqlamp.angri.ru/>`_, Materialized Path for SQLAlchemy. 

对于带等级的数据如果写入频繁, 考虑把排序这部分独立? 例如在内存上面独立一段时间, 或者Flat List蛮快的. 读写同步这部分

`Storing Hierarchical Data in a Database Article <http://www.sitepoint.com/hierarchical-data-database/>`_, 用PHP的解析了MPTT的实现

`Four ways to work with hierarchical data <http://evolt.org/node/4047/>`_, 列出了Recursion, Stack, Flat Table, MPTT四种方法上面的好坏. 

`Models for Hierarchichical Data with SQL and PHP <http://www.slideshare.net/billkarwin/models-for-hierarchical-data>`_, 图文并茂. 69页显示了一个表格 "Choosing the Right Design". Closure Table除了多一个表外, 所有的情况都是Easy.
 
对于Closure Table, "A node even connects to itself", Why? 用来确定自己的身份, 确定自己是根节点? 在 `Karwin <http://karwin.blogspot.com/2010/03/rendering-trees-with-closure-tables.html>`_ 的blog评论中做了解析, 根结点只是一点::

  I have at least three reasons why the self-referencing nodes are useful.

  1. Primary key columns must be non-nullable, and the two columns of ancestor,
     descendant in the closure table serve as the best primary key.

  2. The self-referencing row makes it easier when you add a new child node.
     For example, if you have a path A-B-C-D and you want to add a new child of D,
     you just run:

    	SELECT ancestor, E FROM closure WHERE descendant = D

     If you didn't have a self-referencing row (D,D), 
     you'd have to add the last path (D,E) by hand anyway.

  3. Most of the time when you want to query either a chain of ancestors of D,
     you'd want to include D in the result too. E.g. a breadcrumbs query.
     If you didn't have the self-referencing row, you'd get the ancestors of D,
     but not D itself, from this query:

          SELECT ancestor FROM closure WHERE descendant = D

      With the self-referencing row, you get ancestors and also D itself.
      You get a similar benefit when you want to query for a subtree 
      and include the top node of that subtree.

           SELECT descendant FROM closure WHERE ancestor = B

      So yes, I do think the self-referencing row gives several benefits,
      even though it looks superfluous at first.


`What are the Options for Storing Hierarchical Data in a Relational Database? <http://stackoverflow.com/questions/4048151/what-are-the-options-for-storing-hierarchical-data-in-a-relational-database>`_, 提问者理出了好多选择. 提问艺术的高手.

`Hierarchical data in RDBMSs <http://troels.arvin.dk/db/rdbms/links/#hierarchical>`_, 很全面的数据收集整理

`Postgresql ltree <http://www.postgresql.org/docs/current/static/ltree.html>`_, This module implements a data type ltree for representing labels of data stored in a hierarchical tree-like structure. 


<!-- Fri Dec  2 16:59:20 CST 2011 -->

[update] 简单的对比记录

1. 经常读写但不在意查询子树结构的, 用Adjacency List(邻接列表). 递归查询
2. 不经常改写, 且需要经常查子树结构, 用nested sets
3. Path Enumeration查询直接子节点比较麻烦. 对生成路径有天然的优势.
   树结构排序也需要额外的字段协调
4. Closure Table -> 两个表. 查询子孙很容易. 但构建目录结构需要一次"group by"
   在非按ID顺序情况下构建树缺乏优势.

没有银弹. Adjacency List是基础模型, 然后可以按需求选择对应的方法/变种进行辅助. django-mptt_ 实现中, 除了lft/ rght外, 保存对应的父节点, 还引入tree_id, level两个字段来辅助查询/构建树结构.

再来, 还有NoSQL组合使用的可能. 

<!-- Mon Dec 19 15:22:43 CST 2011 -->
