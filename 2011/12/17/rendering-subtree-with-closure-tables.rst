public: yes
tags: [database, postgresql]

========================================
Rendering SubTrees with Closure Tables
========================================

First of all, thanks Bill Karwin, for all his different posts and articles on Closure Tables, and his great book `SQL Antipatterns <http://pragprog.com/book/bksqla/sql-antipatterns>`_ (I read the Chinese version)

this note base on Bill Karwin's `Rendering Trees with Closure Tables <http://karwin.blogspot.com/2010/03/rendering-trees-with-closure-tables.html>`_, the page is great, and telling us how to render trees with closure tables. part from this page:

.. sourcecode:: mysql

    select group_concat(n.label order by n.node separator ' -> ') as path
    from closure d
    join closure a on (a.descendant = d.descendant)
    join nodes n on (n.node = a.ancestor)
    where d.ancestor = 1 and d.descendant != d.ancestor
    group by d.descendant;

Got::

   +-------------------------------------------------+
   | path                                            |
   +-------------------------------------------------+
   | rootree -> 1stbranch                            |
   | rootree -> midbranch                            |
   | rootree -> midbranch -> corebranch              |
   | rootree -> midbranch -> corebranch -> leafnodes |
   | rootree -> lastbranch                           |
   | rootree -> lastbranch -> lastleaf               |
   +-------------------------------------------------+

but, how about when I just want to render the subtree? I need the tree show of the "midbrance", I change the query to:

.. sourcecode:: mysql

   select group_concat(n.label order by n.node separator ' -> ') as path
   from closure d
   join closure a on (a.descendant = d.descendant)
   join nodes n on (n.node = a.ancestor)
   where d.ancestor = 3 
   -- and d.descendant != d.ancestor
   group by d.descendant;
   
I got::

        +-------------------------------------------------+
	| path                                            |
	+-------------------------------------------------+
	| rootree -> midbranch                            |
	| rootree -> midbranch -> corebranch              |
	| rootree -> midbranch -> corebranch -> leafnodes |
	+-------------------------------------------------+


I don't care about the *roottree* any bit. I want the output like this, just the tree view of the *midbranch*::

        +----------------------------------+
	| path                             |
	+----------------------------------+
   	| midbranch                        |
	| midbranch->corebranch            |
	| midbranch->corebranch->leafnodes |
	+----------------------------------+

I'm just a sql newbie, and find out a solution like this finally:

.. sourcecode:: mysql

    select group_concat(n.label order by n.node separator '->') as path
    from closure d 
    left join closure a on (a.descendant = d.ancestor) 
    join nodes n on (n.node = d.ancestor)
    where a.ancestor = 3
    group by d.descendant;

the point of the change is, *just fire the group operate on the subset*:

.. sourcecode:: mysql

   -- get the subset closure table of node.id == 3
   select d.* from closure d 
   left join closure a on (a.descendant = d.ancestor)
   where a.ancestor = 3

This sulotion also work on the *roottree*.

I don't know the performance about this change. From pgAdmin3 explain -- I had a PostgreSQL version of closure tables and first found out this problem and sulotion on it -- two version share the save query plan, but the later get less row in the *Hast Join* (the subset). 

I can't prove it absolute right, but it work so far so good. I even thought how to use "closure table + path enumeration" to solve this problem at first. Maybe this was not a problem, but I'm just scratch my own itch.

Here is my PostgreSQL version:

.. sourcecode:: sql
   
   select d.descendant, 
   string_agg(n.label, '/' order by d.ancestor)
   as path
   from closures d 
   left join closures a on (a.descendant = d.ancestor)
   join nodes n on (n.id = d.ancestor)
   where a.ancestor = 3
   group by d.descendant
   order by path


<!-- Sat Dec 17 00:28:32 CST 2011 -->
