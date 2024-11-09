# Linux命令大全

文件和目录
|                               |                               |                               |                               |
| :---------------------------- | :---------------------------- | :---------------------------- | :---------------------------- |
| [cd](#cd命令遍历目录)         | [pwd](#pwd命令显示当前目录)   | [touch](#touch命令创建文件)   | [cp](#cp命令复制文件)         |
| [ln](#ln命令链接文件)         | [mv](#mv命令重命名文件)       | [rm](#rm命令删除文件)         | [mkdir](#mkdir命令创建目录)   |
| [rmdir](#rmdir命令删除目录)   | [file](#file命令查看文件类型) | [cat](#cat命令查看文件内容)   | [more](#more命令查看文件内容) |
| [less](#less命令查看文件内容) | [tail](#tail命令查看文件内容) | [head](#head命令查看文件内容) |                               |

系统管理
|                       |                             |                             |                       |
| :-------------------- | :-------------------------- | :-------------------------- | :-------------------- |
| [ps](#ps命令查看进程) | [top](#top命令实时显示进程信息) | [kill](#kill命令结束进程) | [killall](#killall命令结束进程) |
| [mount](#mount命令挂载存储媒体) | [unmount](#unmount命令卸载设备) | [df](#df命令显示磁盘使用情况) | [du](#du命令目录的磁盘使用情况) |

## bash手册

`man`命令用来访问存储在Linux系统上的手册页面，在想要查找的工具的名称前面输入`man`命令，就可以找到那个工具对应的手册条目
```shell
man ls
```

## 文件和目录

### cd命令遍历目录


绝对文件路径定义了在虚拟目录结构中该目录的确切位置，以虚拟目录的根目录开始，相当于目录的全名。

绝对路径总是以（/）作为起始

破浪号（~）表明shell会话位于主目录中,一般为`/home/xxxuser`

```shell
~$ cd /home/maodou

~$ pwd
/home/user
```

#### 相对路径

基于当前位置的目标文件路径，以目录名或者一个特殊字符开始

两种特殊字符用于相对文件路径
- 单点号：表示当前目录
- 双点号：表示当前目录的父目录

```shell
~$ cd /home
/home$ cd user

~$ pwd
/home/user

~$ cd ..
/home$ pwd
/home
```

### pwd命令显示当前目录

pwd命令可以显示出shell会话当前目录，这个目录被称为当前工作目录

```shell
~$ cd /home/maodou

~$ pwd
/home/maodou
```

### touch命令创建文件

touch命令创建指定的新文件，文件的大小为零，touch命令只创建了一个空文件。

**语法**
```shell
touch [OPTION]... FILE...
```

**参数**
- -a, 改变文件访问时间

**示例**
```shell
~$ touch a.txt

~$ ls -l a.txt
-rw-rw-r-- 1 maodou maodou 0 Feb  3 09:18 a.txt
```

### cp命令复制文件

将文件和目录从一个位置复制到另一个位置

**语法**
```shell
cp [OPTION]... [-T] SOURCE DEST
or:  cp [OPTION]... SOURCE... DIRECTORY
or:  cp [OPTION]... -t DIRECTORY SOURCE...
```
**参数**

- -i, 询问是否需要覆盖已有文件，如果不回答y，不会进行复制文件
- -R, 递归复制整个目录的内容

**示例**
```shell
# 复制a.txt到当前目录为b.txt
~$ cp a.txt b.txt

~$ ls -l
total 0
-rw-rw-r-- 1 maodou maodou 0 Feb  3 09:18 a.txt
-rw-rw-r-- 1 maodou maodou 0 Feb  3 11:34 b.txt

# 将tmp下的a.txt文件复制到当前工作目录
~$ cp /tmp/a.txt .
```

### ln命令链接文件

同一个文件的两份或者多份副本，除了保存多份单独的物理文件副本之外，还可以保存一份物理文件副本和多个虚拟副本--链接

- 符号链接
  - 以路径的形式存在。类似于Windows操作系统中的快捷方式
  - 软链接可以 跨文件系统 ，硬链接不可以
  - 软链接可以对一个不存在的文件名进行链接
  - 软链接可以对目录进行链接
- 硬链接
  - 硬链接，以文件副本的形式存在。但不占用实际空间
  - 不允许给目录创建硬链接
  - 硬链接只有在同一个文件系统中才能创建

**语法**

默认为硬链接
```shell
ln [OPTION]... [-T] TARGET LINK_NAME
or:  ln [OPTION]... TARGET
or:  ln [OPTION]... TARGET... DIRECTORY
or:  ln [OPTION]... -t DIRECTORY TARGET...
```

**参数**

- -s，符号链接（软链接）
- -v 显示详细的处理过程
- -d 允许超级用户制作目录的硬链接

**示例**
```shell
# 复制a.txt到当前目录为b.txt
~$ ln a.txt b.txt
~$ ls -l
total 0
-rw-rw-r-- 2 maodou maodou 0 Feb  4 12:14 a.txt
-rw-rw-r-- 2 maodou maodou 0 Feb  4 12:14 b.txt

~$ ln -s a.txt b.txt
```

### mv命令重命名文件

将文件和目录移动到另一个位置或者重新命名

**语法**
```shell
mv [OPTION]... [-T] SOURCE DEST
or:  mv [OPTION]... SOURCE... DIRECTORY
or:  mv [OPTION]... -t DIRECTORY SOURCE...
Rename SOURCE to DEST, or move SOURCE(s) to DIRECTORY.
```

**参数**
- -i, 询问是否需要覆盖已有文件，如果不回答y，不会进行移动

**示例**
```shell
~$ ls -l
total 0
-rw-rw-r-- 1 maodou maodou 0 Feb  4 13:08 a.txt

# 修改文件名称
~$ mv a.txt b.txt
~$ ls -l
total 0
-rw-rw-r-- 1 maodou maodou 0 Feb  4 13:08 b.txt

# 移动文件位置并修改文件名称
~$ mv b.txt tmp/a.txt
~$ ls -l tmp/
total 0
-rw-rw-r-- 1 maodou maodou 0 Feb  4 13:08 a.txt
```

### rm命令删除文件

删除已有的文件

**语法**
```shell
rm [OPTION]... [FILE]...
```

**参数**
- -i, 询问是否需要删除已有文件，如果不回答y，不会进行删除
- -f, 强制删除，无需确认
- -f, 递归删除目录以及目录中的内容
- -d, 删除空目录
  
### mkdir命令创建目录

创建目录

**语法**
```shell
mkdir [OPTION]... DIRECTORY...
```

**参数**
- -m, 设置文件模式
- -p, 根据需要创建父目录

**示例**
```shell
~$ mkdir new_dir

# tmp目录不存时，则创建tmp
~$ mkdir tmp/new_dir
```

### rmdir命令删除目录

删除目录，默认情况下，`rmdir`命令只能删除空目录

**语法**
```shell
rmdir [OPTION]... DIRECTORY...
```

**参数**
- -p, 根据目录及其祖先目录

**示例**

```shell
~$ ls new_dir/
a.txt
# 只能删除空目录
~$ rmdir new_dir
rmdir: failed to remove 'new_dir': Directory not empty

# -p 删除a/b/c， a/b， a
~$ mkdir -p a/b/c
~$ rmdir -p a/b/c
```

### 查看文件内容

#### file命令查看文件类型

探测文件类型

**语法**
```shell
file [OPTION...] [FILE...]
```

**参数**
- -z, 尝试查看压缩文件内部
- -b, 列出辨识结果时，不显示文件名称

**示例**

```shell
# 探测目录
~$ file new_dir
new_dir: directory

# 探测文本
~$ file a.txt 
a.txt: ASCII text

~$ file -b a.txt 
ASCII text
```

#### cat命令查看文件内容

显示文本文件

**语法**
```shell
cat [OPTION]... [FILE]...
```

**参数**
- -n, 给所有行增加行号
- -b, 和 -n 相似，不对空白行进行编号
- -s, 抑制重复的空输出行，连续两行以上空白行，替换为一行空白
- -T, 制表符显示为 ^I

**示例**

```shell
# 查看文件的内容
~$ cat a.txt

~$ cat -n a.txt

~$ cat -b a.txt
```

#### more命令查看文件内容

显示文本文件的内容，但会在每页数据之后停下来。

按空白键（space）就往下一页显示，按b键就会往回（back）一页显示

**语法**
```shell
more [options] <file>...
```

**参数**
- -d, 给所有行增加行号
- -c, 不滚动、显示文本和清除行尾
- -p, 不滚动、清理屏幕并显示文本

**示例**

```shell
# 查看文件的内容
~$ more a.txt
```

#### less命令查看文件内容

less命令与more类似，less 可以随意浏览文件，支持翻页和搜索，支持向上翻页和向下翻页。

**语法**
```shell
less [options] <file>...
```

**参数**
- -b, 设置缓存区的大小
- -i, 忽略大小写
- -m, 显示类似more命令的百分比

显示文本后移动操作
- h 显示帮助界面
- q 退出less命令
- b 向上翻一页
- d 向后翻半页
- u 向前滚动半页
- y 向前滚动一行
- 空格键 滚动一页
- 回车键 滚动一行

**示例**

```shell
# 查看文件的内容
~$ less a.txt
```

#### tail命令查看文件内容

tail命令会显示文件最后几行的内容（文件的尾部）

**语法**
```shell
tail [OPTION]... [FILE]...
```

**参数**
- -c, 显示最后几个字符
- -n, 显示文件的尾部 n 行内容

**示例**

```shell
# 查看文件的内容
~$ tail -n 10 a.txt

~$ tail -c 5 a.txt
```

#### head命令查看文件内容

head命令会显示文件开头几行的内容

**语法**
```shell
head [OPTION]... [FILE]...
```

**参数**
- -c, 显示开始几个字符
- -n, 显示文件的开始 n 行内容

**示例**

```shell
# 查看文件的内容
~$ head -n 10 a.txt
# -n 10 可以省略写为 -10
~$ head -10 a.txt

~$ head -c 5 a.txt
```

## 系统管理

### 进程管理

#### ps命令查看进程

输出运行在系统上的所有程序信息，默认情况下ps命令只会显示运行在当前控制台下的属于当前用户的进程

**语法**

```shell
ps [options]
```

**参数**

- -A, 显示所有进程
- -N, 显示与指定参数不符的所有进程
- -e, 显示所有进程
- -f, 显示完整格式的输出
- -F, 显示更多额外的输出

参数可以组合使用，如`ps -ef`，完成格式显示所有的进程

-f参数输出含义

- UID：启动这些进程的用户。
- PID：进程的进程ID。
- PPID：父进程的进程号。
- C：进程生命周期中的CPU利用率。
- STIME：进程启动的系统时间。
- TTY：进程启动时的终端设备。
- TIME：运行进程需要的累计CPU时间。
- CMD：启动的程序名称。

**示例**

```shell
~$ ps -A

~$ ps -f
UID          PID    PPID  C STIME TTY          TIME CMD
maodou         1050    1047  0 11:13 pts/0    00:00:00 -bash
maodou        63948    1050  0 12:27 pts/0    00:00:00 ps -f
```

#### top命令实时显示进程信息

**语法**
```shell
top -hv | -bcEeHiOSs1 -d secs -n max -u|U user -p pid(s) -o field -w [cols]
```

**参数**
- -d <秒数>：指定 top 命令的刷新时间间隔，单位为秒。
- -n <次数>：指定 top 命令运行的次数后自动退出。
- -p <进程ID>：仅显示指定进程ID的信息。
- -u <用户名>：仅显示指定用户名的进程信息。
- -H：在进程信息中显示线程详细信息。
- -i：不显示闲置（idle）或无用的进程。
- -b：以批处理（batch）模式运行，直接将结果输出到文件。
- -c：显示完整的命令行而不截断。
- -S：累计显示进程的 CPU 使用时间。

总体系统信息
- uptime：系统的运行时间和平均负载。
- tasks：当前运行的进程和线程数目。
- CPU：总体 CPU 使用率和各个核心的使用情况。
- 内存（Memory）：总体内存使用情况、可用内存和缓存。

进程信息
- PID：进程ID。
- USER：运行进程的用户名。
- PR（优先级）：进程的优先级。
- NI（Nice值）：进程的优先级调整值。
- VIRT（虚拟内存）：进程使用的虚拟内存大小。
- RES（常驻内存）：进程实际使用的物理内存大小。
- SHR（共享内存）：进程共享的内存大小。
- S：进程的状态（D代表可中断的休眠状态，R代表在运行状态，S代表休眠状态，T代表跟踪状态或者停止状态，Z代表僵化状态）。
- %CPU：进程占用 CPU 的使用率。
- %MEM：进程占用内存的使用率。
- TIME+：进程的累计 CPU 时间。
- COMMAND：进程所对应的命令行名称（启动的程序名）

**示例**
```shell
~$ top
```

#### kill命令结束进程

kill命令可通过进程ID（PID）给进程发信息。默认情况下，kill命令会向命令行中列出的全部PID发送一个`TERM`信号。

要检查kill命令是否生效，可在运行ps或top命令，看看进程是否已停止。

**语法**
```shell
kill [-s sigspec | -n signum | -sigspec] pid | jobspec ... or kill -l [sigspec]
```

**参数**
- -s, 支持指定其他信号值

**示例**
```shell
~$ kill 3940

~$ kill -s HUP 3940
```


#### killall命令结束进程

killall命令可通过进程名来结束进程，也支持通配符。

**语法**
```shell
killall [OPTION]... [--] NAME...
```

**参数**
- -e, 进程需要和名字完全相符
- -i, 忽略大小写
- -l, 列出所有的信号名称
- -s, 支持指定其他信号值

**示例**
```shell
~$ killall mysql

# 使用通配符一定要特别消息
~$ killall http*
```

### 监测磁盘空间

#### mount命令挂载存储媒体

Linux上用来挂载媒体的命令叫mount。默认情况下，mount命令会输出当前系统上挂载的设备列表。

```shell
~$ mount
sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)
proc on /proc type proc (rw,nosuid,nodev,noexec,relatime)
udev on /dev type devtmpfs (rw,nosuid,relatime,size=947696k,nr_inodes=236924,mode=755,inode64)
devpts on /dev/pts type devpts (rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000)
tmpfs on /run type tmpfs (rw,nosuid,nodev,noexec,relatime,size=201124k,mode=755,inode64)
```

mount命令提供如下四部分信息：
- 媒体的设备文件名
- 媒体挂载到虚拟目录的挂载点
- 文件系统类型
- 已挂载媒体的访问状态

要手动在虚拟目录中挂载设备，需要以root用户身份登录，或是以root用户身份运行sudo命令。下面是手动挂载设备的基本命令

**语法**
```shell
 mount [-lhV]
 mount -a [options]
 mount [options] [--source] <source> | [--target] <directory>
 mount [options] <source> <directory>
 mount <operation> <mountpoint> [<target>]
```

```shell
mount -t type device directory
```

type参数指定了磁盘被格式化的文件系统类型。
- vfat：Windows长文件系统
- ntfs：WindowsNT、XP、Vista高级文件系统
- iso9660：标准CD-ROM文件系统

**参数**
- -a, 挂载/etc/fstab文件中指定的所有文件系统
- -v, 详细模式，将会说明挂载设备的每一步
- -f, 模拟挂载设备，不执行实际挂上的动作。通常会和 -v 一起使用。
- -n, 挂载设备，但不注册到/etc/mtab已挂载设备文件中
- -p num, 进行加密挂载时，从文件描述符num中获取密码短语
- -r, 将设备挂载为只读的
- -w, 将设备挂载为可读写的
- -o, 给文件系统添加特定的选项

-o参数允许在挂载文件系统时添加一些以逗号分隔的额外选项

- ro：以只读形式挂载
- rw：以读写形式挂载
- user：允许普通用户挂载文件系统。
- check=done：挂载文件系统时不进行完整性校验。
- loop：挂载一个文件。
  
**示例**

```shell
mount -t vfat /dev/dbl /media/disk
```

#### unmount命令卸载设备

卸载设备，支持通过设备文件或者挂载点来指定要卸载的设备。如果正在使用设备上的文件，系统就不会允许你卸载它。

**语法**

```shell
 umount [-hV]
 umount -a [options]
 umount [options] <source> | <directory>
```

**参数**

- -a, 卸载/etc/fstab文件中指定的所有文件系统
- -n, 卸载时不要将信息存入/etc/mtab文件中。

**示例**

```shell
~$ umount -v /mnt/mymount/ 
```

#### df命令显示磁盘使用情况

用于显示目前在 Linux 系统上的文件系统磁盘使用情况统计

**语法**

```shell
df [OPTION]... [FILE]...
```

```shell
~$ df
Filesystem                        1K-blocks    Used Available Use% Mounted on
tmpfs                                201124    1100    200024   1% /run
/dev/mapper/ubuntu--vg-ubuntu--lv  10218772 5347900   4330200  56% /
tmpfs                               1005620       0   1005620   0% /dev/shm
tmpfs                                  5120       0      5120   0% /run/lock
/dev/sda2                           1768056  131964   1527960   8% /boot
tmpfs                                201124       4    201120   1% /run/user/1000
```

命令输出如下：
- 设备的设备文件位置；
- 能容纳多少个1024字节大小的块
- 已用了多少个1024字节大小的块
- 还有多少个1024字节大小的块可用
- 已用空间所占比例
- 设备挂载到了哪个挂载点上

**参数**

- -h, 使用人类可读的格式，按照1024幂
- -H, 使用人类可读的格式，按照1000幂
- -l, 限制列出本地文件系统
- -k, 1024k字节大小的块
- -i, --inodes 列出 inode 资讯，不列出已使用 block

**示例**

```shell
~$ df

~$ df -i
Filesystem                        Inodes IUsed  IFree IUse% Mounted on
tmpfs                             251405   807 250598    1% /run
/dev/mapper/ubuntu--vg-ubuntu--lv 655360 83203 572157   13% /
tmpfs                             251405     1 251404    1% /dev/shm
tmpfs                             251405     3 251402    1% /run/lock
/dev/sda2                         114688   316 114372    1% /boot
tmpfs                              50281    25  50256    1% /run/user/1000
```

#### du命令目录的磁盘使用情况

用于显示某个特性目录（默认情况下是当前目录）的磁盘使用情况

**语法**

```shell
du [OPTION]... [FILE]...
```

命令输出如下：
- 设备的设备文件位置；
- 能容纳多少个1024字节大小的块
- 已用了多少个1024字节大小的块
- 还有多少个1024字节大小的块可用
- 已用空间所占比例
- 设备挂载到了哪个挂载点上

**参数**

- -c, 显示所有已列出文件总的大小
- -h, 按用户易读的格式输出大小，K，M，G代替字节
- -s, 显示每个输出参数的总计。
- -a, 显示目录中所有的目录和文件大小

**示例**

```shell
~$ du /home/maodou/
4	/home/maodou/.cache
4	/home/maodou/new_dir
4	/home/maodou/.ssh
4	/home/maodou/.config/procps
8	/home/maodou/.config
64	/home/maodou/


~$ du -c /home/maodou/
4	/home/maodou/.cache
4	/home/maodou/new_dir
4	/home/maodou/.ssh
4	/home/maodou/.config/procps
8	/home/maodou/.config
64	/home/maodou/
64	total
```

## 网络

### netstat

netstat命令用于显示网络状态

**语法**

```shell
netstat [-vWeenNcCF] [<Af>] -r
```

**参数**

- -a, 显示所有连线中的Socket
- -u, 显示UDP传输协议的连线状况
- -r, 显示路由表

<Socket>={-t|--tcp} {-u|--udp} {-U|--udplite} {-S|--sctp} {-w|--raw} {-x|--unix} --ax25 --ipx --netrom

**示例**

```shell
/home$ netstat -nu
Active Internet connections (w/o servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
udp        0      0 192.168.71.79:68        192.168.71.1:67         ESTABLISHED
```
