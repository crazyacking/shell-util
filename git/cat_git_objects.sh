#!/bin/bash
# 放到 .git目录下面
cd objects
find . -type f|grep -E '^./\w+'|awk -F / '{print "echo =======object : "$2$3"===== && git cat-file -p "$2$3" &&echo"}'|xargs -0  bash -c
