#!/bin/bash

# 使用说明 ：将本shell放到.git目录下面
# 添加执行权限： chmod +x cat_git_objects.sh
# 在.git目录中执行： ./cat_git_objects.sh
# 执行结果： 把所有objects按照本地修改时间顺序排列，然后依次显示内容； 如下格式：
#=======object:commit:a29cb3f41e7eaa2318b647c73337c732781f61dd=====
#tree cc03b00148f239047ee7d057d428d87a3207244e
#parent e5b7647deb9743c2e100c2dc17d83cfe7d45d4ee

# 进入目录
cd objects

# 查找文件
find . -type f|\
#按照修改时间排序
xargs ls -ltar |\
#提取文件名列
awk '{print $9}'|\
#提取objects
grep -E '^./\w+'|\
#生成显示object内容的命令（包装 git cat-file 命令）
awk -F / '{print "\
    #输出object描述前缀
    echo -n =======object:&&\
    #获取object类型并输出，不换行
    git cat-file -t "$2$3"| xargs echo -n && \
    #输出object名称和后缀
    echo :"$2$3"===== && \
    #输出object内容
    git cat-file -p "$2$3" &&\
    #换行
    echo\
"}'|\
# 执行命令
xargs -0  bash -c
