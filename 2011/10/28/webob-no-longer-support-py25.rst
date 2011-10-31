public: yes
tags: [pyramid]

===================================
WebOb-1.2不再支持Python2.5
===================================

WebOb更新, 在 `1.2a1 <http://docs.webob.org/en/latest/news.html>`_ 已经明确不支持Python2.5. 而继续在Python2.5环境安装pyramid-1.2.1时会, 会自动安装最新的WebOb版本, 导致 *paster create --list-templates* 出现错误. 

此时可以卸载WebOb的安装, 改用WebOb-1.1.1版本::

  pip uninstall webob
  pip install webob==1.1.1


另外, WebOb1.2已经支持Python3.2, 而Pyramid对Python3的支持也在进行中: `Python 3 Porting <https://github.com/Pylons/pyramid/wiki/Python-3-Porting>`_

[Fri Oct 28 17:09:05 CST 2011]
