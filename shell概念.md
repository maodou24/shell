# shell概念

## shell的类型

系统启动什么样的shell程序取决与你个人的用户ID配置。在etc/passwd文件列出了默认的shell程序。只要用户登录到某个虚拟控制台终端或是在GUI中启动终端仿真器，默认的shell程序就会开始运行

```shell
cat /etc/passwd
...
:x:1000:1000:maodou:/home/maodou:/bin/bash
```

bash shell程序位于/bin目录内，bash是一个可执行程序

另一个默认shell是/bin/sh，它作为一个默认的系统shell，用于那些需要在启动时使用的系统shell脚本

并不是必须一直使用默认的交互shell。可以使用发行版中所有可用的shell

## shell的父子关系

在CLI提示符后输入/bin/bash命令或其他等效的bash命令时，会创建一个新的shell程序。这个shell程序被称为子shell


在生成子shell进程时，只有部分父进程的环境被复制到子shell环境中

子shell可以从父shell中创建，也可以在另一个子shell中创建。

```shell
~$ ps -f
UID          PID    PPID  C STIME TTY          TIME CMD
maodou       213713  213712  0 11:42 pts/0    00:00:00 -bash
maodou       213949  213870  0 11:43 pts/0    00:00:00 ps -f

~$ bash
~$ ps -f
UID          PID    PPID  C STIME TTY          TIME CMD
maodou       213713  213712  0 11:42 pts/0    00:00:00 -bash
maodou       213870  213713  0 11:42 pts/0    00:00:00 bash
maodou       213949  213870  0 11:43 pts/0    00:00:00 ps -f

~$ ps --forest
    PID TTY          TIME CMD
 213713 pts/0    00:00:00 bash
 213870 pts/0    00:00:00  \_ bash
 220025 pts/0    00:00:00      \_ ps

 ~$ exit
```

### 进程列表

一行中指定要一次运行的一系列命令，通过命令列表来实现，在命令之间加入分号（;）

```shell
~$ pwd; ls; ec /etc/; pwd; cd ; pwd; ls
/home/maodou
a.txt  new_dir
ec: command not found
/home/maodou
/home/maodou
a.txt  new_dir
```

进程列表，将这些命令包含在括号里。

每一对括号就会生成一个子shell来执行括号里的命令

```shell
~$ （pwd; ls; ec /etc/; pwd; cd ; pwd; ls; echo $BASH_SUBSHELL）
/home/maodou
a.txt  new_dir
ec: command not found
/home/maodou
/home/maodou
a.txt  new_dir
1
```

可通过环境变量`BASH_SUBSHELL`数值来判断有没有子shell

### 子shell用法

#### 后台模式

后台模式中运行命令可以在处理命令的同时让出CLI，以供他用。

```shell
# 会话暂停10s，然后返回CLI提示符
sleep 10
```

若是想将命令置入后台模式，可以在命令末尾加上字符&。

在CLI提示符返回之前，会出现两条信息，第一条信息是显示在方括号中的后台作业号。第二条是后天作业的进程ID

可以通过jobs命令来显示后台作业信息，后台作业完成时，状态从Running变为Done


```shell
~$ sleep 100&
[1] 235723  # 方括号中为后台作业号，后台作业进程ID
~$ ps -f
UID          PID    PPID  C STIME TTY          TIME CMD
maodou       213713  213712  0 11:42 pts/0    00:00:00 -bash
maodou       235723  213713  0 12:08 pts/0    00:00:00 sleep 100
maodou       235797  213713  0 12:08 pts/0    00:00:00 ps -f

~$ jobs
[1]+  Running                 sleep 100 &
```

#### 将进程列表置入后台

```shell
~$ (sleep 2; echo $BASH_SUBSHELL; sleep 2)
1

# & 进程列表置入后台
~$ (sleep 2; echo $BASH_SUBSHELL; sleep 2)&
[1] 333523
~$ 1
# 回车键后显示
[1]+  Done                    ( sleep 2; echo $BASH_SUBSHELL; sleep 2 )
~$ 

```

#### 协程

协程可以同时做两件事。在后台生成一个子shell，并在这个子shell中执行命令。

扩展语法可以进程起别名`coproc My_job {sleep 10}`，扩展语法必须确保在第一个花括号（{）和命令之间有一个空格。还必须保证以分号（;）结尾，分号和闭花括号（}）之间也得有一个空格。

```shell
~$ coproc sleep 10
[1] 374167

~$ jobs
[1]+  Running                 coproc COPROC sleep 10 &
```

## shell的内建命令

### 外部命令

外部命令，有时候也称为文件系统命令，是存在于bash shell之外的程序。并不是shell程序的一部分。外部命令通常位于/bin、/usr/bin、/sbin、/usr/sbin中。

可通过which和type命令查找，which命令只显示外部命令文件

```shell
~$ which cd
~$ type cd
cd is a shell builtin
```

外部命令执行时，会创建一个子进程。这种操作称为衍生（forking）

### 内建命令（buildin）

内建命令不需要使用子进程来执行。它们已经和shell编译成一体，作为shell工具的组成部分存在。不需要借助外部程序文件来运行

可以利用type命令来了解某个命令是否是内建的。`type [-afptP] name [name ...]`

参数
- -a，显示包含名为 NAME 的可执行文件的所有位置。

```shell
~$ type cd
cd is a shell builtin
~$ type exit
exit is a shell builtin
```

#### history命令

查看最近用过的命令列表

```shell
~$ history
    1  ls
    2  history
```

可以唤回并重用历史列表中最近的命令，使用`!!`，然后按回车键就能唤出刚刚用过的那条命令来使用。使用惊叹号和命令在历史列表中的编号可以唤回历史列表中的任意一条命令。

命令历史记录被保存在隐藏文件.bash_history中，它位于用户的主目录中

```shell
~$ ls
a.txt  new_dir

~$ !!
ls
a.txt  new_dir

~$ !1
ls
a.txt  new_dir
```

#### 命令别名

alias命令是另一个shell的内建命令，命令别名允许你为常用的命令创建另一个名称，可以降低输入量

可通过alias命令以及选项-p查看当前可用的别名，`alias -p`

使用alias命令创建属于自己的别名。别名仅在它所被定义的shell进程中才有效。

```shell
~$ alias li =`ls -li`

~$ li
```