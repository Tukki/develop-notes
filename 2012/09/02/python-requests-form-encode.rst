public: yes
tag: [requests, python]

====================================
python requests 设置POST编码方式
====================================


源于一个使用的错误, 然后挖了一下requests的源码. 

想用requests发个带图片的微博. 要用到 `upload <http://open.weibo.com/wiki/2/statuses/upload>`_ 接口, 注意事项时使用"multipart/form-data"编码方式.

先是按其文档上面的说明, 使用files的方式进行文件发送

.. sourcecode: python
   
   >>> files = {'file': ('pic', open('test.jpg', 'rb'))}
   >>> r = requests.post(url, data=data, files=files)

返回错误. 以为必需把pic放到data里面进行发送. 该过来尝试了一次. 报headers不支持. `支持Custom Headers <http://docs.python-requests.org/en/latest/user/quickstart/#custom-headers>`_::
   
   >>> headers = {'content-type': 'multipart/form-data'}
   >>> r = requests.post(url, data=data, headers=headers)

还是不行. 散弹式寻找答案, 甚至以为要自己 `设置BOUNDARY <http://code.activestate.com/recipes/146306-http-client-to-post-using-multipartform-data/>`_. 不过这样就不像Requests了. 

在requests的 `issues <https://github.com/kennethreitz/requests/issues/737>`_ 看到这样一个示例::

  >>> print post('http://httpbin.org/post', data={'X': 'a'}, files={'X': open('/etc/hosts')}).content

原来最开始的错误只是... 用错方式来指定文件的名字了? 

   >>> files = {'pic': open('test.jpg', 'rb')}

再post就可以了. 成功发送图片微博

于是想看看requests这部分的实现是怎样的. 在models.py里面的send函数:

.. sourcecode:: python

   if self.files:
       (body, content_type) = self._encode_files(self.files)
   else:
       if self.data:
           body = self._encode_params(self.data)
           if isinstance(self.data, str) or isinstance(self.data, builtin_str) or hasattr(self.data, 'read'):
               content_type = None
           else:
               content_type = 'application/x-www-form-urlencoded'
 
   # Add content-type if it wasn't explicitly provided.
   if (content_type) and (not 'content-type' in self.headers):
       self.headers['Content-Type'] = content_type

在有files字段的时候调用的_encode_file会encode_multipart_formdata. 而只有data情况下, 使用的是 urlencode, 并且把content_type设为"application/x-www-form-urlencoded".

这就解析了为什么我把pic放到data里面, 并强制设置headers都不行.. 得到的headers值根本就是不符合规定的.


