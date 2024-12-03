# sed&gawd

## gawk程序

gawk程序的基本格式如下：
`gawk options program file`

gwak选项
｜选项｜描述｜
｜-｜-｜
｜-F fs｜指定行中划分数据字段的字段分隔符｜
｜-f file| 从指定的文件中读取程序 |
｜-v var=value｜定义gawk程序中的一个变量及其默认值｜
｜-mf N｜指定要处理的数据文件的最大字段｜
｜-mr N｜指定数据文件中的最大数据行数｜
｜-w keyword｜指定gawk的兼容模式或者警告等级｜

1. 从命令行读取程序脚本

`gawk '{print "Hello World"}'`

`Ctrl+D`组合键会在bash中产生一个EOF字符。

2. 使用数据字段变量

gawk命令自动给一行中的每个数据元素分配一个变量.
默认情况下：
- `$0`代表整个文本行
- `$1`代表文本行中的第1个数据字段
- `$2`代表文本行中的第2个数据字段
- `$n`代表文本行中的第n个数据字段

每个数据字段都是通过字段分隔符划分的。gawk中默认的字段分隔符是任意的空白字符。

3. 在程序脚本中使用多个命令

多个命令之间放个分号
```shell
echo "My name is Rich" | gawk '{$4="Christine"}; print $0'
```

或者使用次提示符一次一行的输入程序脚本命令
```shell
$ gawk ‘{
> $4="Christine"
> print $0}'

My name is Rich
My name is Christine
```

4. 从文件中读取程序

`gawk -F: -f script.gawk /etc/passwd`

5. 在处理数据前运行脚本

gawk允许指定程序脚本何时运行。默认情况下，gawk会从输入中读取一行文本，然后针对改行的数据执行程序脚本。

使用`BEGIN`关键字，可以强制gawk在读取数据前执行`BEGIN`关键字背后指定的程序

6. 在处理数据后运行脚本

使用`END`关键字。
