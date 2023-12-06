#!/usr/bin/env bash

files=$(find -maxdepth 1 -name ".*" -type f  | grep -v .gitignore)
for file in `echo $files`; do
	file=$(basename $file)
	echo $(pwd)/$file
	ln -s $(pwd)/$file ~/$file  # 创建软连接
done
