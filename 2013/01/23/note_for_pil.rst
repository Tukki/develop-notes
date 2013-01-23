public: yes
tag: [python, PIL]

=======================
note for PIL
=======================

这次, 在 `word_cloud <https://github.com/amueller/word_cloud>`_ 基础上面, 进行改动. 虽然还有改不动的地方, 记录收获到的东西. 备忘.  同时多接触了一个库, numpy. 


1. unicode support 

   ImageDraw.text 默认不支持中文(可能时系统问题), 需要指定合适的font, 用truetype类型指定大小输出即可. 一开始折腾没在意, 各种unicode/str转换, 输出一堆乱码. 
   在stackoverflow找到解决方法, 字库!! 后来找美工给了两个字库, hy2gjim.ttf/msyh.ttf. 


2. 字体旋转

   用ImageFont.TransposedFont,  可以指定orientaiton把文字旋转处理, 再draw.text


3. 单词/句子的实际大小

   一个时font.getsize(), 另外一个时draw.textsize()
   前者时获取字体的width/height. 
   后者在setfont后, 获取的时输出时占用的空间. box_size


4. 输出换行

   draw.text()不负责处理换行.. 处理英文可以用 `textwrap <http://docs.python.org/2/library/textwrap.html>`_,  在stackoverflow有 `demo <http://stackoverflow.com/questions/7698231/python-pil-draw-multiline-text-on-image>`_
   中文没化时间找更好的方法. 因为每行的长度差不多, 换行可能就只有几个字, 比较挫地直接由最后一个字重试, 取整句话的实际输出长度, 再判断是否过长, 往前遍历截取. 知道满足. 后面截断的就再换行重试.



5. 圆角处理.

   找到这篇文章 `Simple Image masking with PIL <http://tobias.klpstn.com/2008/02/10/simple-image-masking-with-pil/>`_, 其实原理没来得及搞明白. 利用浮层遮盖?  不知道找到圆角边框不够圆滑, 还是没抄到其中的主要意思, 效果不好... 没成. 
   ps. 这里可以先合并大图再进行缩略. 这样不用换一个比例找一个图层. 


6. 图片合并

   用 Image.paste, 有先后顺序, 同一位置后面覆盖前面. 油画~



  
  
   
      
