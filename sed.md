# sed

## 文本处理

sed编辑器被称为流编辑器，会在编辑器处理数据之前基于预先提供的一组规则来编辑数据流，

1. 一次从输入中读取一行数据
2. 根据所提供的编辑器命令匹配数据
3. 按照命令修改流中的数据
4. 将新的数据输出到STDOUT

流编辑器将所有的命令与一行数据匹配完毕后，它会读取下一行数据并重复这个过程。在流编辑器处理完流中的所有数据，它就会终止。
sed命令格式：
`sed options script file`

1. 在命令行定义编辑器命令

默认情况下，sed编辑器会将指定的命令应用到STDIN输入流上。这样你可以直接将数据通过管道输入sed编辑器处理。
`echo "This is a test" | sed 's/test/big test/'`

sed编辑器不会修改文本文件数据，只会将修改的数据发送到STDOUT。

2. 在命令行使用多个编辑器命令

sed命令执行多个命令时，增加-e选项
`sed -e 's/brown/green/'; s/dog/cat/ data1.txt`

3. 从文件中读取编辑器命令

如果有大量要处理的sed命令，将它们放在一个单独的文件中
`sed -f script1.sed data1.txt`

## sed编辑器基础

### 替换选项

1. 替换标记

替换命令默认情况下只替换每行中出现的第一个处。要让替换命令能够替换一行中不同地方出现的文本必须使用替换标记。
`s/pattern/replacement/flags`
有4种可用的替换标记：

- 数字，表明新文本将替换第几处模式匹配的地方
- g，表明新文本将替换所有匹配的文本
- p，表明原先行的内容要打印出来
- w file，将替换的结果写到文件中

2. 替换字符

感叹号被用作字符串分隔符
`sed 's!/bin/bash!/bin/csh!' /etc/passwd`

### 使用地址

默认情况下，在sed编辑器中使用的命令会作用于文本数据的所有行。如果只想将命令作用于特定行或某些行，则必须用行寻址（line addressing）。
在sed编辑器中有两种形式的行寻址：
- 以数字形式表示行区间
- 用文本模式来过滤出行

`[address]command`
或者
```shell
address {
    command1
    command2
    command3
}
```

1. 数字方式的行寻址
`sed 3s/dog/cat/`
2. 使用文本模式过滤器
`sed /pattern/s/dog/cat/`
3. 命令组合
```shell
$ sed '2{
> s/fox/elephant/
> s/dog/cat/
> }' data1.txt
```

### 删除行

`sed 'd' data1.txt`

操作不会删除原始文件

### 插入和附加文本

sed编辑器允许向数据流插入和附加文本行。必须在sed命令中单独指定新行。

- 插入（insert）命令（i）会在指定行前增加一个新行；
- 附加（append）命令（a）会在指定行后增加一个新行。

操作格式：
```shell
sed '[address]command\
new line'
```


### 修改行

修改（change）命令允许修改数据流中整行文本的内容.必须在sed命令中单独指定新行。
操作格式：
```shell
sed '3c\
> This is a changed line of text.' data6.txt
```

### 转换命令

转换（transform）命令（y）是唯一可以处理单个字符的sed编辑器命令。转换命令格式
如下。
`[address]y/inchars/outchars/`

### 打印

打印数据流中的信息：

- p命令用来打印文本行；
- 等号（=）命令用来打印行号；
- l（小写的L）命令用来列出行。

1. 打印行

p命令可以打印sed编辑器输出中的一行，例如：
`echo "this is a test" | sed 'p'`

2. 打印行号

等号命令会打印行在数据流中的当前行号。行号由数据流中的换行符决定。每次数据流中出
现一个换行符

`sed '=' data1.txt`

3. 列出行

列出（list）命令（l）可以打印数据流中的文本和不可打印的ASCII字符。

`sed 'l' data1.txt`


### 使用sed 处理文件


1. 写入文件

w命令用来向文件写入行。该命令的格式如下：
`[address]w filename`

其中filename可以使用相对路径或绝对路径

2. 从文件读取数据

读取（read）命令（r）允许你将一个独立文件中的数据插入到数据流中。
读取命令的格式如下：
`[address]r filename`

## sed进阶

### 多行命令

#### next命令

1. 单行的next命令
小写的n命令会告诉sed编辑器移动到数据流中的下一文本行，而不用重新回到命令的最开始再执行一遍。

2. 多行的next命令
多行版本的next命令（用大写N）会将下一文本行添加到模式空间中已有的文本后。这样的作用是将数据流中的两个文本行合并到同一个模式空间中。文本行仍然用换行符分
隔，但sed编辑器现在会将两行文本当成一行来处理。