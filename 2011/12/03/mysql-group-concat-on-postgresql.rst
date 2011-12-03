public: yes
tags: [postgresql, database]

================================
MySQL group_concat on PostgreSQL
================================

源于 `Rendering Trees with Closure Tables <http://karwin.blogspot.com/2010/03/rendering-trees-with-closure-tables.html>`_ 例子是基于MySQL的, 列出Path用的 `GROUP_CONCAT() <http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html#function_group-concat>`_ 在Postgresql上面没有对应的直接实现. 下面是自己对应Category版本的解决方法:

.. sourcecode:: sql
   
   select d.descendant, 
   array_to_string(array_agg(cat.name order by cat.id), '/') -- line_2
   as path
   from closure d
   join closure a on (a.descendant = d.descendant)
   join category cat on (cat.id = a.ancestor)
   where d.ancestor = 1 and d.descendant != d.ancestor
   group by d.descendant
   order by path;   -- line_last

如果是PostgreSQL-9.0以上版本的, 可以用 `string_agg <http://developer.postgresql.org/pgdocs/postgres/functions-aggregate.html>`_ 代替上面的array_to_string::
  
   string_agg(cat.label, '/' order by cat.id) -- line_2

其中, 如果line_2里面不用 "order by cat.id", 得到的路径是倒序的::
   
  "sub11/sub1/root"

如果没有line_last的"order by path", 得到的结果是按"descendant"升序的, 没有把目录树结构顺序表现出来::

  "root/sub1"
  "root/sub2"
  "root/sub1/sub11"
  "root/sub2/sub21"
  "root/sub2/sub21/sub211"

因为还没有实现文中提到的lenght, 所以也是假定祖先目录的id值比子孙目录的id值小.


列出在Google找到的有用信息.

`MySQL function group_concat in PostgreSQL <http://www.pgsql.cz/index.php/PostgreSQL_SQL_Tricks#MySQL_function_group_concat_in_PostgreSQL>`_, 里面提到个"workaround"(应急方案?). 用"array_to_string + array_agg"组合处理.

`array age on postgresql wiki <http://wiki.postgresql.org/wiki/Array_agg>`_, 说明了在8.4版本前的PostgreSQL该怎样去实现这个 *array_agg*.

`STRING AGGREGATION IN POSTGRESQL, SQL SERVER, AND MYSQL <http://www.postgresonline.com/journal/archives/191-stringagg.html>`_, 详细的对比式实现

中文世界没详细找, 这里有一个 `postgresql如何实现group_concat功能 <http://hi.baidu.com/bsdgo/blog/item/7a79fd02359ef71f1c9583f0.html>`_, 但相对来说, 信息量还不够.


<!-- Sat Dec  3 21:05:25 CST 2011 -->
