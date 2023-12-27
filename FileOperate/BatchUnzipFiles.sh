#!/bin/bash
# TODO: 编写函数工厂函数，根据文件类型来执行不同的解压命令
function UnzipTar()
{
  tar -zxvf $1 -C $2
}

function UnzipZip()
{
  unzip $1 -d $2
}

function Unzip7z()
{
  7za x $1 -r -o$2
}

for file in `ls *.tgz`
do
  final_dir=`echo "$file" | cut -d "." -f1`
  #mkdir "$final_dir" && tar -zxvf "$file" -C "$final_dir"
  mkdir "$final_dir"
  UnzipTar "$file" "$final_dir"
done



