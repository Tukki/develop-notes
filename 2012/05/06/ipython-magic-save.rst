public: yes
tags: [python, tips]
summary: |
   saving a iPython interactive session

using IPython magic-save
==========================

利用ipython证明一段交互逻辑后, 想保存记录. 在stackoverflow找到 `How to save a Python interactive session? <http://stackoverflow.com/questions/947810/how-to-save-a-python-interactive-session>`_, 然后知道IPython的 `magic-save <http://ipython.org/ipython-doc/stable/api/generated/IPython.core.interactiveshell.html?highlight=save#IPython.core.interactiveshell.InteractiveShell.magic_save>`_::

  Save a set of lines or a macro to a given filename.
  Usage:
    %save [options] filename n1-n2 n3-n4 ... n5 .. n6 ... 

轻松保存记录到指定文件, 然后, 稍作编辑. 一个脚本大致成型.

<Sun May  6 01:55:05 CST 2012>

