#!/bin/bash

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
