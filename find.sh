#!/bin/bash
#2020-12-27-14:12

#This colour
cyan='\e[0;36m'
green='\e[0;34m'
okegreen='\033[92m'
lightgreen='\e[1;32m'
white='\e[1;37m'
red='\e[1;31m'
yellow='\e[1;33m'
#显示前10个占用空间最大的文件或目录：　　#已易读的格式显示指定目录或文件的大小，-s选项指定对于目录不详细显示每个子目录或文件的大小

echo -e $red"============================================================================="
echo -e $white"NOTE : "
echo -e $white"Find the file!"
echo""
echo -e $red""
echo -e $while "选项	用法"
echo "-empty	查找空白文件或目录"
echo "-group	按组查找"
echo "-name	按文档名称查找"
echo "-iname	按文档名称查找，且不区分大小写"
echo "-mtime	按修改时间查找"
echo "-size	按容量大小查找"
echo "-type	按文档类型查找，文件（f）、目录(d)、设备(b，c)、链接(l)等"
echo "-user	按用户查找"
echo "-exec	对找到的档案执行特定的命令"
echo "-a	并且"
echo "-o	或者"
echo "-maxdepth  指定遍历搜索的最大深度 "
echo "-mindepth  指定开始遍历搜索的最小深度"
echo "                                                                             "
echo -e $red"============================================================================="
echo -e $white	"	        Show me how to find a file        "
echo -e $red"============================================================================="
echo "                                                                "
echo -e $white""
# locate
#locate命令其实是"find -name"的另一种写法，但是要比后者快得多。
#原因在于它不搜索具体目录，而是搜索一个数据库（/var/lib/locatedb），这个数据库中含有本地所有文件信息。
#Linux系统自动创建这个数据库，并且每天自动更新一次，所以使用locate命令查不到最新变动过的文件。
#为了避免这种情况，可以在使用locate之前，先使用updatedb命令，手动更新数据库。
#
du -s * | sort -nr | head
echo -e $red"************************查找当前目录下名称为test.txt的文档******************************"
find -name test.txt
echo -e $red"***************************************************************************************"
sleep 5s

echo -e $red"************************查找/root目录下所有名称以.log结尾的文件***************************"
find  /var/log/  -name  "*.log"
echo -e $red"***************************************************************************************"
sleep 5s

echo -e $red"************************不区分大小写查找文件 test****************************************"
find  /root/ -iname  "test"
echo -e $red"***************************************************************************************"
sleep 5s

echo -e $red"************************查找系统中所有的空白文件*****************************************"
find   /root  -empty
echo -e $red"***************************************************************************************"
sleep 5s

echo -e $red"************************查找系统中所属组为root的文件**************************************"
find  /root  -group  root
echo -e $red"***************************************************************************************"
sleep 5s

echo -e $red"************************查找系统中所有3天内被修改过的文件*********************************"
find  /root -mtime  -3
echo -e $red"***************************************************************************************"
sleep 5s

echo -e $red"************************查找系统中所有4天前被修改过的文件*********************************"
find  /root  -mtime  +4
echo -e $red"***************************************************************************************"
sleep 5s

echo -e $red"************************查找系统中2天前的当天被修改过的文件*******************************"
find  /root  -mtime   2
echo -e $red"***************************************************************************************"
sleep 5s

echo -e $red"************************搜索当前目录中，所有过去10分钟中更新过的普通文件********************"
find . -type f -mmin -10 #如果不加-type f参数，则搜索普通文件+特殊文件+目录。
echo -e $red"***************************************************************************************"
sleep 5s

echo -e $red"************************查找当前目录下大于10MB的文件*************************************"
find  ./  -size   +10M
echo -e $red"***************************************************************************************"
sleep 5s

echo -e $red"************************查找当前目录下的所有普通文件**************************************"
find  ./  -type   f
echo -e $red"****************************************************************************************"
sleep 5s

echo -e $red"************************查找当前目录下文件大小大于1M的文件*********************************"
find ./ -type f -size +1M  #./当前路径 -type 文件类型 -size 文件大小 +大于 -小于 无 等于
echo -e $red"****************************************************************************************"
sleep 5s

echo -e $red"************************查找计算中root所拥有的所有文件*************************************"
find  /root  -user  root
echo -e $red"****************************************************************************************"
sleep 5s

echo -e $red"************************查找当前目录下大于1MB的文件后列出文件的详细信息*********************"
find  ./  -size  +1M  -exec ls -l {} \;
echo -e $red"****************************************************************************************"
sleep 5s

echo -e $red"************************查找计算机中所有大于1MB的文件**************************************"
find   /root  -size   +1M  -a  -type  f
echo -e $red"****************************************************************************************"
sleep 5s

#查找当前目录下大于1M的文件的三种方法
#(1使用find的参数实现
find . -maxdepth 1 -size +1000000c
#(2使用ls+awk组合管道
find . -maxdepth 1 -size +1000000c;
#(3使用find+ll+awk组合（管道）
find ./ -name "*" -maxdepth 0 -exec ls -l {} \;|awk '{if($5>1000000) print $8}'
sleep 5s

##################################################################################################
echo -e $yellow"============================================================================="
echo -e $white"NOTE : "
echo -e $white"Find the file!"
echo""
echo -e $yellow""
echo "[options]主要参数："
echo "-c：只输出匹配行的计数。"
echo -e $white"-i：不区分大小写"
echo "-h：查询多文件时不显示文件名。"
echo "-l：查询多文件时只输出包含匹配字符的文件名。"
echo "-n：显示匹配行及行号。"
echo "-s：不显示不存在或无匹配文本的错误信息。"
echo "-v：显示不包含匹配文本的所有行"
echo -e $yellow"============================================================================="
echo "pattern正则表达式主要参数："
echo "　　\:忽略正则表达式中特殊字符的原有含义。"
echo "　　　　^：匹配正则表达式的开始行。"
echo "　　　　$: 匹配正则表达式的结束行。"
echo "　　　　\<：从匹配正则表达 式的行开始。"
echo "　　　　\>：到匹配正则表达式的行结束。"
echo "　　　　[ ]：单个字符，如[A]即A符合要求。"
echo "　　　　[ - ]：范围,如[A-Z]，即A、B、C一直到Z都符合要求。"
echo "　　　　.：所有的单个字符。               "
echo "      　*：有字符,长度可以为0   "
echo "                                                                             "
echo -e $yellow"============================================================================="
echo -e $white	"		Show me how to find a String!  "
echo -e $yellow"============================================================================="
echo "                                                                "
echo -e $white""

echo -e $yellow"************************查找index文件中包含html的行**************************************"
grep 'html' /root/www/html/index.html
echo -e $yellow"****************************************************************************************"

echo -e $yellow"************************查找所有以i开头的文件中包含html的行********************************"
grep 'html' i*
echo -e $yellow"****************************************************************************************"
sleep 5s
echo -e $yellow"****查找当前目录下所有文件中包含html的行——若目录下含有多级子目录，则用 grep -r 'html' ./*****"
grep 'html' /root/www/html/*
echo -e $yellow"****************************************************************************************"

echo -e $yellow" 行首/行尾查找——首行查找在所找字符串前加^,尾行则在所找字符串后加$ "
echo -e $yellow" 查找字符.需要加转义字符 \.如下在行尾 查找字符"..." ——grep '\.\.\.$' ./*  "
