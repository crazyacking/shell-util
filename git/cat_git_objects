#!/bin/bash
# 放到 .git目录下面
cd objects
find . -type f|grep -E '^./\w+'|awk -F / '{print "echo =======objects : "$2"/"$3"===== && git cat-file -p "$2$3}'|xargs -0  bash -c
