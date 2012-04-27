public: yes
tags: [python, django, sqlalchemy, failure]
summary: |
   简单记录下自己今天错误的做法

Using SQLAlchemy in Django
=================================

现在的工程还是基于Django, 不过ORM部分已经确认用SQLAlchemy了. 现在也建了一层DAL来管理数据非业务相关的实现, 看接口定义, 有点像让粒度小一点. 提供复用 ::

   UserDAL.get_user_by_id(id)
   ActionDAL.action(user_id, value) 

首先有个想法, 想让Session在request-response周期内自动管理transcations, 自然得动用Middleware. 有点懒, 直接上代码(未完整测试).

.. sourcecode:: python

   from django.utils.functional import SimpleLazyObject
   from somewhere import Session

   def get_dbSession(request): 
       if not hasattr(request, '_cached_dbSession'): 
           request._cached_dbSession = Session() 
 	   #http://docs.sqlalchemy.org/en/latest/orm/session.html#committing 
           #In autocommit mode, a transaction can be initiated by calling the begin() method. 
           request._cached_dbSession.begin()   
       return request._cached_dbSession 
 
   def has_dbSession(request): 
       return hasattr(request, '_cached_dbSession') 
 
 
   class SQLAlchemySessionMiddleware(object): 
 
       def process_request(self, request): 
           request.dbSession = SimpleLazyObject(lambda: get_dbSession(request)) 
 
       def process_response(self, request, response): 
           if has_dbSession(request): 
               dbSession = request.dbSession 
               try: 
                   dbSession.commit() 
               except: 
                   dbSession.rollback() 
                   raise 
           return response 
 
       def process_exception(self, request, exception): 
           if has_dbSession(request): 
              dbSession = request.dbSession 
              dbSession.rollback() 


用了SimpleLazyObject来管理request.dbSession是考虑到并非每个request都会用到dbSession, 就直接懒惰处理. 

像是解决问题了. 

两个困惑. 1)是不是需要用request.dbSession初始化DAL/参数传入; 2)如果不传值, 如何做到DALs上面能共用一个Session上下文.

记得以前用Pyramid的时候也有遇到这个情况. 只是没总结好. 今晚回来好好查了下SQLAlchemy的文档, 找到似曾相似的 `Contextual/Thread-local Sessions <http://docs.sqlalchemy.org/en/latest/orm/session.html#contextual-thread-local-sessions>`_, 使用scoped_session::

   By default, this context is the current thread.

查查已有实现, 才发现现在定义的Session只是sessionmaker()出来. 改用scoped_session, 上面两个疑惑一并解决了吧.

 
如果不是dbSession.begin(). 应该会忽略以下一个问题: 这个Middleware是否导致Session的Transaction太长了? 而且transaction的使用也不灵活. 再者, scoped_session的使用, 已经可以让整个Middleware实现无用化, 用错方法来解决问题了. 

现在想, 或在一个view级别的decorators足够了, django.db.transaction.commit_on_success. 再者, 过度设计了. 现在的系统需要用到transaction了吗? 

<Sat Apr 28 02:07:45 CST 2012>

