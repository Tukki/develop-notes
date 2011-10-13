public: yes
tag: [linux]

==================================
Linux run levels and services 
==================================


Run Levels
============

from `Wikipadia <http://en.wikipedia.org/wiki/Runlevel>`_::

        Red Hat Linux and Fedoar and CentOS:
	====== ====================
	 ID          Description
	====== ====================
	  0           Halt
	  1        Single-User mode
	  2       Multi-user mode console logins only(without networking)
	  3       Multi-user mode, console logins only
	  4       Not used/User-definable
	  5       Multi-User mode, with display manager as well as console logins(X11)
	  6       Reboot
	====== ====================

which services are started in which runlevels can be managed with the *chkconfig* tool, which keeps its configuration settings under /etc/rc.d/.


Services Run Order
=====================

From `Digitalpeer <http://www.digitalpeer.com/id/changelinux>`_::

      Go to /etc/rc.d/ and you'll notice rcX.d folders. The X in those directory 
   names represent runlevels. Go to the runlevel you want to edit and you'll notice
   a whole bunch of files in the format SXXservice and KXXservice. The S files 
   represent startup files and the K files represent the kill files. The important
   thing to note here is the XX number in those files. Those represent the order in
   which those files are executed. Simply make the number higher or lower to move
   the service around in startup or shutdown.


 
Switching Run Levels
=====================
  
::

  init <Run Level number>


