public: yes
tag: [python, jinja2]

================
Jiaja2 Notes
================

Call a python function from jiaja2, from `stackoverflow <http://stackoverflow.com/questions/6036082/call-a-python-function-from-jinja2>`_

.. sourcecode:: python

   from jinja2 import Environment, FileSystemLoader

   def clever_function(a, b):
       return u''.join([b, a])

   env = Environment(loader=FileSystemLoader('/path/to/templates'))
   env.globals['clever_function'] = clever_function

下面也提到, You can 'inject' namespaces (modules), functions, class instances etc to the Environment instance
