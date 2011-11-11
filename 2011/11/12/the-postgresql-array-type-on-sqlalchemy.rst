public: yes
tags: [sqlalchemy]

==========================================
在SQLAlchemy使用Postgresql的Array类型
==========================================

.. sourcecode:: python

   from sqlalchemy.dialects import postgresql

   demo_table = Table('demo', metadata,
                    Column('id', Integer, primary_key=True),
		    Column('uids', postgresql.ARRAY(Integer, mutable=True)),
		    )

   class Demo(object):
       pass

   mapper(Demo, demo_table)


1. 定义表结果(?)时, 指定mutable=True, 才能使对uids的直接调用append等方法的修改生效, 否则flush/commit时不会更新数据库, 即使手动调用"instance_state(object).modified=True". 除非每次都 *demo.uids = new_list*. (使用版本0.7.1)

2. demo_table的uids在上面的定义是允许存在nullable. 不保存数据和保存空列表时两个不同的情况. 在postgresql, array的保存格式为 "{,,,,}"

3. postgresql支持SQL2003标准下的Array, Mysql还至今没有支持
   http://forge.mysql.com/worklog/task.php?id=2081

[Sat Nov 12 01:43:09 CST 2011]

