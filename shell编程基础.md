# shell脚本编程基础

## 构建基本脚本

### 创建shell脚本文件

创建shell脚本文件时，必须在文件的第一行指定要使用的shell。其格式为：
```shell
#!/bin/bash
```
在通常的shell脚本中，井号(#)用作注释行。shell并不会处理shell脚本中的注释行（第一行是个例外，第一行#后面的惊叹号会告诉shell用哪个shell来运行脚本）

```shell
#!/bin/bash

date
who
```

bash shell如何跨目录执行新脚本，可以将新建的脚本增加到PATH环境变量的目录中，shell会通过PATH环境变量查找命令。

- 将shell脚本文件所在的目录添加到PATH目录中
- 在提示符中使用绝对路径或者相对路径引用shell脚本文件


### 显示消息 echo

echo命令可以将输出显示在脚本所运行的控制台显示器上。通常情况不需要使用引号将要显示的文本划定起来。

echo命令可以使用单引号或双引号来划定文本字符串

echo -n: 表示不换行输出，把文本字符串和命令输出显示在同一行

### 使用变量

#### 环境变量

环境变量名称之前使用`$`来使用环境变量

```shell
#!/bin/bash
echo "HOME : $HOME"

echo "HOME : ${HOME}"
```

#### 用户变量

除了环境变量，shell脚本还允许在脚本中定义和使用自己的变量。定义变量允许临时存储数据并在整个脚本中使用

用户变量由字母、数字或者下划线组成的文本字符串，长度不超过20个。用户变量区分大小写

使用等号将值赋给用户变量。在变量、等号和值之间不能出现空格

```shell
var1=10
var2=testing
var3="hello world"
```

shell脚本会自动决定变量值的数据类型
与系统变量类似，用户变量可以通过美元符引用。

```shell
#!/bin/bash
days=10
guest="andy"

echo "$guest checked in $day days ago"
```

#### 命令替换

从命令输出中提取信息，并将其赋给变量

- 反引号字符（ ` ）
- $()格式

```shell
#!/bin/bash

testing=`date`
echo "date: $testing"

name=$(who)
echo "user: " $name
```

### 重定向输入和输出

#### 输出重定向

最基本的重定向将命令的输出发送到一个文件中。bash shell用大于号(>)来完成这项功能

`command > outputfile`

重定向符创建一个文件outputfile，将command命令的输出重定向到该文件中，如果该文件已经存在了，新的文件数据覆盖以后的数据。

如果不想覆盖文件原有内容，将命令的输出追加到已有文件中，可使用`>>`来追加数据

```shell
~/shell_study$ date > temp

~/shell_study$ who >> temp

~/shell_study$ cat temp
Thu Mar 28 02:37:56 PM UTC 2024
maodou      pts/0        2024-03-28 14:25 (192.168.2.200)
```

#### 输入重定向

输入重定向将文件的内容重定向到命令。

输入重定向符号是小于号（<）：

`command < inputfile`

### 管道

有时需要将一个命令的输出作为另一个命令的输入，这个过程叫作管道连接（piping）。

由两个
竖线构成，一个在另一个上面。然而管道符号的印刷体通常看起来更像是单个竖线（|）。在美式
键盘上，它通常和反斜线（\）位于同一个键。管道被放在命令之间，将一个命令的输出重定向
到另一个命令中：
`command1 | command2`

Linux系统会同时运行这两个命令，在系统内部将他们连接起来。在第一个命令产生输出的同时，输出会被立即送给第二个命令。数据传输不会用到任何中间文件或者缓存区。

### 执行数学运算

#### expr命令

ARG1 | ARG2 如果ARG1既不是null也不是零值，返回ARG1；否则返回ARG2
ARG1 & ARG2 如果没有参数是null或零值，返回ARG1；否则返回0
ARG1 < ARG2 如果ARG1小于ARG2，返回1；否则返回0
ARG1 <= ARG2 如果ARG1小于或等于ARG2，返回1；否则返回0
ARG1 = ARG2 如果ARG1等于ARG2，返回1；否则返回0
ARG1 != ARG2 如果ARG1不等于ARG2，返回1；否则返回0
ARG1 >= ARG2 如果ARG1大于或等于ARG2，返回1；否则返回0
ARG1 > ARG2 如果ARG1大于ARG2，返回1；否则返回0
ARG1 + ARG2 返回ARG1和ARG2的算术运算和
ARG1 - ARG2 返回ARG1和ARG2的算术运算差
ARG1 * ARG2 返回ARG1和ARG2的算术乘积
ARG1 / ARG2 返回ARG1被ARG2除的算术商
ARG1 % ARG2 返回ARG1被ARG2除的算术余数
STRING : REGEXP 如果REGEXP匹配到了STRING中的某个模式，返回该模式匹配
match STRING REGEXP 如果REGEXP匹配到了STRING中的某个模式，返回该模式匹配
substr STRING POS LENGTH 返回起始位置为POS（从1开始计数）、长度为LENGTH个字符的子字符串
index STRING CHARS 返回在STRING中找到CHARS字符串的位置；否则，返回0
length STRING 返回字符串STRING的数值长度
+ TOKEN 将TOKEN解释成字符串，即使是个关键字
(EXPRESSION) 返回EXPRESSION的值

```shell
$ expr 5 \* 2 # 需要转义字符
```

### 使用方括号

在bash中，在将一个数学运算结果赋给某个变量时，可以用美元符和
方括号（$[ operation ]）将数学表达式围起来

```shell
$ var1=$[1 + 5]
$ echo $var1
```

### 退出脚本

#### 查看退出状态码

Linux提供了一个专门的变量$?来保存上个已执行命令的退出状态码。

按照惯例，一个成功结束的命令的退出状态码是0。如果一个命令结束时有错误，退出状态码就是一个正数值。

- 0 命令成功结束
- 1 一般性未知错误
- 2 不适合的shell命令
- 126 命令不可执行
- 127 没找到命令
- 128 无效的退出参数
- 128+x 与Linux信号x相关的严重错误
- 130 通过Ctrl+C终止的命令
- 255 正常范围之外的退出状态码

#### exit命令

默认情况下，shell脚本会以脚本中的最后一个命令的退出状态码退出。

你可以改变这种默认行为，返回自己的退出状态码。exit命令允许你在脚本结束时指定一
个退出状态码。

```shell
个退出状态码。
$ cat test13
#!/bin/bash
# testing the exit status
var1=10
var2=30
var3=$[$var1 + $var2]
echo The answer is $var3
exit 5
$
```

退出状态码被缩减到了0～255的区间。shell通过模运算得到这个结果。一个值的模就是被除
后的余数。最终的结果是指定的数值除以256后得到的余数。在这个例子中，指定的值是300（返
回值），余数是44，因此这个余数就成了最后的状态退出码。

## 使用结构化命令

### 使用if-then语句

```shell
if command
then
    commands
fi
```

bash shell的if语句会运行if后面的那个命令。如果该命令的退出状态码是0（该命令成功运行），位于then部分的命令就会被执行。如果该命令的退出状态码是其他值，then部分的命令就不会被执行，bash shell会继续执行脚本中的下一个命令。fi语句用来表示if-then语句到此结束。

### if-then-else语句

```shell
if command
then
    commands
else
    commands
fi
```

当if语句中的命令返回退出状态码0时，then部分中的命令会被执行，这跟普通的if-then
语句一样。当if语句中的命令返回非零退出状态码时，bash shell会执行else部分中的命令。

### 嵌套if

```shell
if command1
then
    commands
else
    commands
    if command2
    then
        commands
    fi
fi
```

可以使用else部分的另一种形式：elif。这样就不用再书写多个if-then语句了。elif使
用另一个if-then语句延续else部分。
```shell
if command1
then
    commands
elif command2
then
    more commands
fi
```

elif语句行提供了另一个要测试的命令，这类似于原始的if语句行。如果elif后命令的退出状态码是0，则bash会执行第二个then语句部分的命令。

注意：在elif语句中，紧跟其后的else语句属于elif代码块。它们并不属于之前的if-then代码块。

### test命令

```shell
test condition

if test condition
then
    commands
else
    commands
fi
```

如果不写test命令的condition部分，它会以非零的退出状态码退出，并执行else语句块。

```shell
#!/bin/bash

my_var="null"
if test $my_var  # my_var有值，状态码为成功
then
    echo "$my_var expression returns a True"
else
    echo "$my_var expression returns a False"
fi
```

变量`my_var`中包含内容时，充当test命令测试条件时，返回的退出状态码为0。这使得then语句块中的语句得以执行。如果该变量中没有包含内容，就会出现相反的情况。

bash shell提供了另一种测试条件，无需在if-then语句中声明test命令。
```shell
if [ condition ]
then
    commands
fi
```

方括号定义了测试条件。注意，第一个方括号之后和第二个方括号之前必须加上一个空格，否则就会报错。
test命令可以判断三类条件：
- 数值比较
- 字符串比较
- 文件比较

#### 数值比较

test命令的数值比较功能

 检查n1是否与n2相等
n1 -ge n2 检查n1是否大于或等于n2
n1 -gt n2 检查n1是否大于n2
n1 -le n2 检查n1是否小于或等于n2
n1 -lt n2 检查n1是否小于n2
n1 -ne n2 检查n1是否不等于n2

| 比较      | 描述                   |
| --------- | ---------------------- |
| n1 -eq n2 | 检查n1是否大于或等于n2 |
| n1 -gt n2 | 检查n1是否大于n2       |
| n1 -le n2 | 检查n1是否小于或等于n2 |
| n1 -lt n2 | 检查n1是否小于n2       |
| n1 -ne n2 | 检查n1是否不等于n2     |

```shell
#!/bin/bash
value1=10
value2=11

if [ $value1 -gt 5]
then
    echo ""
```

bash shell只能处理整数。如果你只是要通过echo语句来显示这个结果，那没问题。但是，在基于数字的函数中就不行了，例如我们的数值测试条件

#### 字符串比较

| 比较         | 描述                   |
| ------------ | ---------------------- |
| str1 = str2  | 检查str1是否和str2相同 |
| str1 != str2 | 检查str1是否和str2不同 |
| str1 < str2  | 检查str1是否比str2小   |
| str1 > str2  | 检查str1是否比str2大   |
| -n str1      | 检查str1的长度是否非0  |
| -z str1      | 检查str1的长度是否为0  |

要测试一个字符串是否比另一个字符串大就是麻烦的开始。当要开始使用测试条件的大于或
小于功能时，就会出现两个经常困扰shell程序员的问题：
- 大于号和小于号必须转义，否则shell会把它们当作重定向符号，把字符串值当作文件
名；
- 大于和小于顺序和sort命令所采用的不同。


#### 文件比较

| 比较                                   | 描述                                     |
| -------------------------------------- | ---------------------------------------- |
| -d file                                | 检查file是否存在并是一个目录             |
| -e file                                | 检查file是否存在                         |
| -f file                                | 检查file是否存在并是一个文件             |
| -r file                                | 检查file是否存在并可读                   |
| -s file                                | 检查file是否存在并非空                   |
| -w file                                | 检查file是否存在并可写                   |
| -x file                                | 检查file是否存在并可执行                 |
| -O file                                | 检查file是否存在并属当前用户所有         |
| -G file                                | 检查file是否存在并且默认组与当前用户相同 |
| file1 -nt file2 检查file1是否比file2新 |
| file1 -ot file2 检查file1是否比file2旧 |

1. 检查目录

`-d`会检查指定的目录是否存在于系统

```shell
#!/bin/bash
# Look before you leap

jump_dir=/home/maodou

if [ -d $jump_dir ]
then
    echo "the $jump_dir directory exists"
    cd $jump_dir
else
    echo "the $jump_dir directory doest not exists"
fi
```

2. 检查对象是否存在
`-e`脚本代码中使用对象前检查文件或目录是否存在。

3. 检查文件
`-f`检查文件对象是否存在

4. 检查是否可读
`-r`检查文件是否可读

5. 检查空文件
`-s`检查文件是否为空，当比较成功时，说明文件中有数据

6. 检查是否可写
`-w`判断对文件是否有可写权限

7. 检查文件是否可以执行
`-x`判断特性文件是否有执行权限

8. 检查所属关系
`-O`是否是文件的属主

9. 检查默认组关系
`-G`检查文件默认组，如果匹配了用户的默认组，检查成功

10. 检查文件日期
`-nt`比较一个文件是否比另一个文件新（创建日期更近），`-ot`比较一个文件是否比另一个文件旧

### 复合条件测试

if-then语句允许你使用布尔逻辑来组合测试。有两种布尔运算符可用：
- [ condition1 ] && [ condition2 ]
- [ condition1 ] || [ condition2 ]
第一种布尔运算使用AND布尔运算符来组合两个条件。要让then部分的命令执行，两个条件都必须满足。

### case命令

有了case命令，就不需要再写出所有的elif语句来不停地检查同一个变量的值了。case命令会采用列表格式来检查单个变量的多个值。

```shell
case variable in
pattern1 | pattern2) commands1;;
pattern3) commands2;;
*) default commands;;
esac
```

case命令会将指定的变量与不同模式进行比较。如果变量和模式是匹配的，那么shell会执行为该模式指定的命令。可以通过竖线操作符在一行中分隔出多个模式模式。星号会捕获所有与已知模式不匹配的值。

```shell
#!/bin/bash
case $USER in
maodou)
    echo "Welcome, $USER"
testing)
    echo "test user"
*)
    echo "Sorry, you are not"
esac
```

## 更多的结构化命令

### for命令

重复执行一系列命令在编程中很常见。通常你需要重复一组命令直至达到某个特定条件，比如处理某个目录下的所有文件、系统上的所有用户或是某个文本文件中的所有行。bash shell提供了for命令，允许你创建一个遍历一系列值的循环。每次迭代都使用其中一个值来执行已定义好的一组命令。下面是bash shell中for命令的基本格式。

```shell
for var in list
do
    commands
done
```

在每次迭代中，变量var会包含列表中的当前值。第一次迭代会使用列表中的第一个值，第二次迭代使用第二个值，以此类推，直到列表中的所有值都过一遍。

#### 读取列表中的值

```shell
#!/bin/bash
for test in A B C D E F
do
    echo The next state is $test
done
```

#### 读取列表中的复杂值

```shell
$ cat badtest1
#!/bin/bash
# another example of how not to use the for command
for test in I don't know if this'll work
do
echo "word:$test"
done
$ ./badtest1
word:I
word:dont know if thisll
word:work
$
```

有两种办法可解决这个问题：
- 使用转义字符（反斜线）来将单引号转义；
- 使用双引号来定义用到单引号的值。

你可能遇到的另一个问题是有多个词的值。记住，for循环假定每个值都是用空格分割的。如果有包含空格的数据值，你就陷入麻烦了。如果在单独的数据值中有空格，就必须用双引号将这些值圈起来。

#### 从变量读取列表

通常shell脚本遇到的情况是，你将一系列值都集中存储在了一个变量中，然后需要遍历变量中的整个列表。也可以通过for命令完成这个任务。

```shell
#!/bin/bash

list="Alabama Alaska Arizona Arkansas Colorado"
for state in $list
do
    echo "Have you ever visited $state?"
done
```

$list变量包含了用于迭代的标准文本值列表。注意，代码还是用了另一个赋值语句向$list变量包含的已有列表中添加（或者说是拼接）了一个值。这是向变量中存储的已有文本字符串尾
部添加文本的一个常用方法。

#### 从命令读取值

生成列表中所需值的另外一个途径就是使用命令的输出。可以用命令替换来执行任何能产生输出的命令，然后在for命令中使用该命令的输出。

```shell
#!/bin/bash

file="states"
for state in $(cat $file)
do
    echo "visit beautiful $state"
done
```

#### 更改字段分隔符

特殊的环境变量IFS，叫作内部字段分隔符（internal field separator）。IFS环境变量定义了bash shell用作字段分隔符的一系列字符。默认情况下，bash shell会将下列字
符当作字段分隔符：
- 空格
- 制表符
- 换行符

bash shell在数据中看到了这些字符中的任意一个，它就会假定这表明了列表中一个新数据字段的开始。

如果你想修改IFS的值，使其只能识别换行符:`IFS=$'\n'`，将这个语句加到脚本中，bash shell在数据中忽略空格和制表符。

#### 用统配符读取目录

可以用for命令来自动遍历目录中的文件。进行此操作时，必须在文件名或路径名中使用通配符。它会强制shell使用文件扩展匹配。文件扩展匹配是生成匹配指定通配符的文件名或路径名的过程。

```shell
#!/bin/bash

# 支持列出多个目录通配符
for file in ./*
do
   if [ -d "$file" ]
   then
       echo "$file is directory"
   elif [ -f "$file" ]
   then
       echo "$file is a file"
   fi
done
```

在Linux中，目录名和文件名中包含空格当然是合法的。要适应这种情况，应该将$file变量用双引号圈起来。如果不这么做，遇到含有空格的目录名或文件名时就会有错误产生。

### C语言风格的for命令

#### C语言的for命令

bash shell也支持一种for循环，它看起来跟C语言风格的for循环类似，是bash中C语言风格的for循环的基本格式。
`for (( variable assignment ; condition ; iteration process))`

```shell
#!/bin/bash
# testing the C-style for loop

for (( i=1; i<=10; i++ ))
do
   echo "The next number is $i"
done
```

### while命令

#### while的基本格式

```shell
while test command
do
    other command
done
```

while命令中定义的test command和if-then语句中的格式一模一样，while命令的关键在于所指定的test command的退出状态码必须随着循环中运行的命令而改变。如果退出状态码不发生变化， while循环就将一直不停地进行下去。
最常见的test command的用法是用方括号来检查循环命令中用到的shell变量的值。
```shell
#!/bin/bash

var1=10

while [ $var1 -gt 0 ]
do
    echo "$var1"
    var1=$[ $var1 - 1 ]
done
```

#### 使用多个测试命令

while命令允许你在while语句行定义多个测试命令。只有最后一个测试命令的退出状态码会被用来决定什么时候结束循环。

#### until命令

until命令和while命令工作的方式完全相反。until命令要求你指定一个通常返回非零退出状态码的测试命令。只有测试命令的退出状态码不为0，bash shell才会执行循环中列出的命令。一旦测试命令返回了退出状态码0，循环就结束了。

```shell
until test commands
do
    other commands
done
```

和while命令类似，你可以在until命令语句中放入多个测试命令。只有最后一个命令的退出状态码决定了bash shell是否执行已定义的other commands。


### 控制循环

#### break命令

break命令是退出循环的一个简单方法。可以用break命令来退出任意类型的循环，包括while和until循环。


1. 跳出单个循环

```shell
for var in list
do
    if [ test $var ]
    then
        break  # 退出循环
    fi
    commands
done
```

2. 跳出内部循环

break命令会自动终止你所在层的循环，当存在多个循环时，只会终止break所在的循环

3. 跳出外部循环

break命令接受命令行参数值：`break n`

其中n指定了要跳出的循环层级。默认情况下n为1

```shell
for var1 in list1
do
    for var2 in list2
    if [ test $var2 ]
    then
        break 2
    fi
    done
done
```

设置为2时，break命令会停止下一级的外部循环

#### continue 命令

```shell
for var in list
do
    if [ test $var ]
    then
        continue  # 提前中止本次循环流程
    fi
    commands
done
```

同break命令，continue命令也支持指定参数`continue n`

### 处理循环的输出

在shell脚本中，你可以对循环的输出使用管道或进行重定向。这可以通过在done命令之后添加一个处理命令来实现

```shell
for file in /home/rich/*
do
if [ -d "$file" ]
then
echo "$file is a directory"
elif
echo "$file is a file"
fi
done > output.txt
```

## 处理用户输入

### 命令行参数

#### 读取参数

bash shell会将一些称为位置参数（positional parameter）的特殊变量分配给输入到命令行中的
所有参数。这也包括shell所执行的脚本名称。位置参数变量是标准的数字：$0是程序名，$1是第一个参数，$2是第二个参数，依次类推，直到第九个参数$9。超过9个后采用${10}

#### 读取脚本名

`$0`参数可以获取shell在命令行启动的脚本名

- 使用另一个命令运行shell脚本，命令会和脚本混在一起
- 执行时携带脚本路径，变量`$0`也会使用整个路径

可以通过`basename`命令或者脚本名
`echo $basename{$0}`

#### 测试参数

在shell脚本中使用命令行参数时要小心些。如果脚本不加参数运行，可能会出问题。

使用参数前一定要检查其中是否存在数据

`[ -n "$1" ]`

### 特殊参数变量

#### 参数统计

特殊变量`$#`含有脚本运行时携带的命令行参数的个数

#### 抓取所有的数据

$*和$@变量可以用来轻松访问所有的参数。这两个变量都能够在单个变量中存储所有的命
令行参数。
$*变量会将命令行上提供的所有参数当作一个单词保存。这个单词包含了命令行中出现的每
一个参数值。基本上$*变量会将这些参数视为一个整体，而不是多个个体。
另一方面，$@变量会将命令行上提供的所有参数当作同一字符串中的多个独立的单词。这样
你就能够遍历所有的参数值，得到每个参数。这通常通过for命令完成。

```bash
#!/bin/bash

# $* and $@

for var in "$*"
do
   echo "\$* = $var"
done



for var in "$@"
do
    echo "\$# = $var"
done
```

```bash
$ ./test3.sh 1 2 3
$* = 1 2 3
$# = 1
$# = 2
$# = 3
```

#### 移动变量

shift命令会根据它们的相对位置来移动命令行参数，使用shift命令时，默认情况下它会将每个参数变量向左移动一个位置

```shell
#!/bin/bash

# shift

count=1
while [ -n "$1" ]
do
    echo "para $count  = $1"
    count=$[ $count + 1 ]
    shift
done 
```

```shell
$ ./test4.sh a b c
para 1  = a
para 2  = b
para 3  = c
```

### 处理选项

#### 查找选项

1. 处理简单选项
   
在提取每个单独参数时，用case语句来判断某个参数是否为选项。
`bash option.sh -a -b -c`

```shell
#!/bin/bash

# extracting command line options

while  [ -n "$1" ]
do
    case "$1" in
      -a) echo "Found the -a option" ;;
      -b) echo "Found the -b option" ;;
      -c) echo "Found the -c option" ;;
       *) echo "$1 is not an option" ;;
    esac
    shift
done
```

2. 分离参数和选项

双破折号(--)来表示选项列表结束，双破折号之前是选项，之后的为参数

`bash option.sh -a -b -c -- test1 test2 test3`

3. 处理带值选项

选项中携带参数
`bash option.sh -a -b test2 -c`

#### getopt命令

`getopt`命令接收任意形式的命令行选项和参数，并自动将它们转换成适当的格式

1. 命令格式
`getopt optstring parameters`

示例
```shell
getopt ab:cd -a -b test1 -cd test2 test3
```

2. 脚本中使用getopt

使用getopt格式化命令行参数 
`set -- $(getopt -q ab:cd "$@")`

getopt命令将空格当做参数分隔符

```shell
getopt ab:cd -a -b test1 -cd “test2 test3” test4
```

会将`“test2 test3”`解析为`'test`和`test3'`

### getopts命令

一次只处理命令行上检测到的一个参数，处理完所有参数后，会退出并返回一个大于0的退出状态码

命令格式
`getopts optstring parameters`

### 获取用户输入

read命令从标准输入（键盘）或另一个文件描述符中接收输入，在收到输入后，read命令会将数据放进一个变量中
`read name`

读取多个变量时，指定多个变量，输入的每个数据值都会分配给变量列表中的下一个变量。如果变量数量不够，剩下的数据全部分配给最后一个变量

命令行中不指定变量，read命令会将它收到的任何数据都放进特殊环境变量`REPLY`中


`read`命令可以用`-t`选项来指定一个计时器。`-t`选项指定了`read`命令等待输入的秒数。当计时器过期后，read命令会返回一个非零的退出状态码

指定参数

- -t: 指定一个定时器，等待输入的秒数
- -s: 屏幕上隐藏输入的内容
- -n: 统计输入的字符数，当输入达到预期的字符数时就自动退出

从文件中读取

```shell
#!/bin/bash

count=1
cat "read.sh" | while read line
do
	echo "Line $count: $line"
	count=$[ $count + 1 ]
done

echo "Finished processing the file"
```

## 呈现数据

### 输入和输出

#### 标准文件描述符

Linux的标准文件描述符

|文件描述符|缩写|描述|
|-|-|-|
|0|STDIN|标准输入|
|1|STDOUT|标准输出|
|2|STDERR|标准错误|

1. STDIN
示例
`cat < testfile` testfile文件中的行作为输入
2. STDOUT
示例
`ls -l > test2`
`who >> test2` 数据追加到test2

#### 重定向错误

1. 只重定向错误
STDERR文件描述被设成2，只重定向错误消息，将该文件描述符值放在重定向符号前
`ls -al badfile 2> test1`

2. 重定向错误和数据
使用两个重定向符号，在符号前面放上待重定向数据所对应的文件描述符，然后指向用于保存数据的输出文件
`ls -al test test2 test3 badtest 2>test6 1>test7`

重定向符号`&>`将STDERR和STDOUT的输出重定向同一个输出文件
`ls -al test badtest &> test7`

### 重定向输出

#### 临时重定向

`>&`重定向到文件描述符

重定向到STDERR
`echo "This is an error message" >&2`

#### 永久重定向

exce命令指定shell脚本在执行期间重定向某个特定的文件描述符

`exec 1>testout` STDOUT重定向到testout文件

### 重定向输入

与重定向输出的方式一致，将STDIN从键盘重定向到其他位置
`exec 1<testfile`

### 创建自己的重定向

#### 创建输出文件描述符

`exec 3>testout`
或者
`exec 3>>testout` 追加到现有文件后面

#### 重定向文件描述符

使用临时描述符保存STDOUT文件描述符，然后再恢复回来

```shell
# 描述符3重定向到描述符1，也就是STDOUT，此时3也是STDOUT
exec 3>&1
# 描述符1默认是STDOUT
exec 1>testout
# 执行以后，描述符1（STDOUT）重定向到文件

# 输出到STDOUT的数据会发送到文件
echo "This should store in the output file"
echo "along with this line."

# 此时描述符3已经是STDOUT
exec 1>&3
# 执行以后，描述符1重定向到描述符3（也就是STDOUT），描述符1恢复为STDOUT
echo "Now things should be normal"

```

#### 创建输入描述符

重定向到文件之前，现将STDIN文件描述符保存到另一个文件描述符，然后再读取文件之后再将STDIN恢复到它原来的位置

#### 创建读写文件描述符

单个文件描述符作为输入和输出，同时一个文件描述符对同一个文件进行读写

对同一个文件进行读写数据读写，shell会维护一个内部指针，指明在文件中的当前位置，任何读或写都会从文件指针上次的位置开始

#### 关闭文件描述符

重定向到特殊描述符号`&-`关闭文件描述符
`exec 3>&-`

#### 列出打开的文件描述符

lsof命令列出整个Linux系统打开的所有文件描述符

### 阻止命令输出

重定向到null文件(`/dev/null`)的特殊文件，shell输出到null文件的任何数据都不会保存，全部都被丢掉了
`ls -al > /dev/null`

### 创建临时文件

#### 创建本地临时文件

`mktemp`在本地目录创建一个文件，创建时指定文件名模板（模板可以包含任意文本文件名，在文件末尾加上6个X）
`mdtemp testing.XXXXXX`

`mktemp`会用6个字符码替换6个X，保证文件名在目录中是唯一的。

#### 在/tmp目录创建临时文件

`mdtemp -t testing.XXXXXX`

#### 创建临时目录

`mdtemp -d dir.XXXXXX`

### 记录消息

tee命令可以将输出同时发送到显示器和日志文件，tee命令将从STDIN过来的数据同时发往两处。一处是STDOUT，另一处是tee命令行所指定的文件名
`tee filename`


## 控制脚本

### 处理信号

Linux利用信号与运行在系统中的进程进行通信

#### Linux信号

| 信号 | 值   | 描述     |
| ---------- | ------ | -------- |
| 1          | SIGHUP  | 挂起进程 |
| 2          | SIGINT | 终止进程 |
| 3          | SIGQUIT | 停止进程 |
| 9          | SIGKILL | 无条件终止进程 |
| 15          | SIGTERM | 尽可能终止进程 |
| 17          | SIGSTOP | 无条件终止进程，但不是终止进程 |
| 18          | SIGTSTP | 停止或暂停进程，但不终止进程 |
| 19          | SIGCONT | 继续运行停止的进程 |

#### 生成信号

1. 中断进程

`Ctrl+C`组合键会生产SIGINT信号，终止shell中当前运行的进程

2. 暂停进程

`Ctrl+Z`组合键会生产SIGTSTP信号，停止shell中运行的任何进程

#### 捕获信号

`trap`命令允许你来指定shell脚本要监看并从shell中拦截的Linux信号

命令的格式：
`trap commands signals`

### 后台模式运行脚本

#### 后台模式运行脚本

命令后面加个`&`符

`test.sh &`

`&`符放到命令后，命令作为系统中的一个独立的后台进程运行

显示的第一行是：
`[1] 3212`
当后台进程结束时，会在终端上显示出一条信息：
`[1] Done        test.sh`

终端会话中使用后台进程时，每一个后台进程都和终端会话终端联系在一起，终端会话退出，后台的进程也会随之退出

### 在非控制台下运行脚本

nohup命令阻止所有发送给该进程的SIGHUP信号。退出终端会话时阻止进程退出。

`nohup command &`

nohup命令运行一个命令，该命令的输出追加到已有的nohup.out文件中，不会同STDOUT和STDERR联系在一起

### 作业控制

#### 查看作业

`jobs`命令查看shell当前正在处理的作业

`$$`变量显示linux系统分配给该脚本的PID

jobs命令参数

- -l: 列出进程的PID以及作业号
- -n: 只列出上次shell发出的通知后改变了状态的作业
- -p: 只列出作业的PID
- -r: 只列出运行中的作业
- -s: 只列出已停止的作业

#### 重启停止的作业

bg命令加上作业号在后台模式重启一个作业
`bg 2`

fg命令加上作业号在前台模式重启一个作业

### 调整谦让度

调度优先级（scheduling priority）是内核分配给进程的CPU时间。在Linux系统中，由shell启动的所有进程的调度器优先级默认都是相同的

调度优先级是个整数值，从-20（最高优先级）到+19（最低优先级）。默认情况下，bash shell以优先级0来启动所有的进程

#### nice命令

nice命令允许你设置命令启动时的调度优先级
`nice -n 10 command`

#### renice命令

renice命令指定运行进程的PID来改变它的优先级
`renice PID`

### 定时运行作业

#### at命令来计划执行作业

at命令允许指定的Linux进程何时运行脚本

at命令格式：
`at [-f filename] time`

at命令能识别多种不同的时间格式：
- 标准的小时和分钟格式，比如10:24
- AM/PM指示符，比如10:15PM
- 特定可命名时间，比如now，noon，midnight或者teatime。
- 标准日期格式，比如MMDDYY、MM/DD/YY、或者DD.MM.YY。
- 文本日期，比如Jul4或者Dec25，加不加年份均可。
- 指定时间增量
   - 当前时间+25min

启动计划作业
`at -f bash test.sh 10:00 PM`

atq命令可以查看系统中有哪些作业在等待
```shell
~$ atq
2	Mon Nov 11 22:00:00 2024 a maodou
```

atrm命令删除等待中的作业
`atrm 2`

#### 安排需要定期执行的脚本

corn时间表采用一种特别的格式来指定作业何时运行。其格式如下：
`min hour dayofmonth month dayofweek command`

eg：每天10：15运行一个命令
`15 10 * * * command`

命令列表必须指定要运行的命令或者脚本的全路径名

2. 构建cron时间表

crontab命令处理cron时间表

`crobtab -l`

3. cron目录

预配置的cron脚本目录，提个4个基本目录：hourly，daily，monthly，weekly

4. anacron

anacron程序用于某个作业错过了执行时间，还能继续运行。