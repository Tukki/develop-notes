public: yes
tag: [postgresql, tips]

=========================================
using sequence to generate global_id
=========================================


使用 `Postgresql Sequence <http://www.postgresql.org/docs/9.2/interactive/sql-createsequence.html>`_ 作为global_id生成器
  
.. sourcecode:: sql

   select nextval('seq');


如果也需要预加载id到应用层, 可以使用 next_id = select setval('seq', currval('seq')+10); 


同事的mysql版本:

.. sourcecode:: sql

    Create Table: CREATE TABLE `ss_id_generator` (
      `next_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
       PRIMARY KEY (`next_id`)
    ) ENGINE=MyISAM AUTO_INCREMENT=10000008501 DEFAULT CHARSET=latin1


使用的是 LAST_INSERT_ID 进行id管理, 并预加载id到应用层缓冲. 还需要注意应用层资源管理, 加锁. 

.. sourcecode:: python

         connection.execute(
                 "update ss_id_generator set next_id=LAST_INSERT_ID(next_id+%s)" % self._fetch_count)
         result = connection.execute("select LAST_INSERT_ID() as next_id")
         next_id = result.fetchone()[0]
         return range(next_id-self._fetch_count, next_id)


global_id 不应该rollback. 
  - 用mysql实现, 尽量用myisam, 用innodb是可以rollback的. 
  - 用postgresql的Sequence, non-transactional.


用Sequence不用写应用层优化多取id避免数据库读写频繁, 带cache选项
   the optional clause CACHE cache specifies how many sequence numbers are to be preallocated and stored in memory for faster access. The minimum value is 1 (only one value can be generated at a time, i.e., no cache), and this is also the default.


用mysql的版本, 需要在应用层缓存多个id, 然后利用线程锁管理. 实现起来麻烦度增加.  

使用Sequence也避免了mysql版本导致的id浪费. (N个实例有N*m(缓冲数)个id预生成)


Sequence也可以一次取多个出来缓存. 也有更强大但复杂的版本
   select nextval('seq') from generate_series(1, 1000);

如果用PostgreSQL做db backend, 用Sequence跨表, 无需应用层协助. 

.. sourcecode:: sql
   
   CREATE SEQUENCE common_fruit_id_seq;

   CREATE TABLE apples (
       id      INT4 DEFAULT nextval('common_fruit_id_seq') NOT NULL,
       price   NUMERIC
   );

   CREATE TABLE oranges (
        id      INT4 DEFAULT nextval('common_fruit_id_seq') NOT NULL,
        weight  NUMERIC
   );



mysql 记录数据 + postgreql sequence global_id 组合也不错. 各司其职


有用的链接:

`PostgreSQL create sequence <http://www.postgresql.org/docs/9.2/interactive/sql-createsequence.html>`_

`getting multiple values from sequences <http://www.depesz.com/2008/03/20/getting-multiple-values-from-sequences/>`_

`FAQ: Using Sequences in PostgresSQL <http://www.neilconway.org/docs/sequences/>`_


