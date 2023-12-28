#!/bin/bash
function UnzipTar()
{
  printf "unzip tgz or tar.gz %s to dir %s\n" "$1" "$2"
  tar -zxf "$1" -C "$2"
}

function UnzipZip()
{
  printf "unzip zip %s to dir %s\n" "$1" "$2"
  unzip "$1" -d "$2"
}

function Unzip7z()
{
  printf "unzip 7z %s to dir %s\n" "$1" "$2"
  7za x "$1" -r -o"$2"
}

function RecognizeFileType()
{
  # get the subfix of each file, if file type is zip, 7z, tar, tar.gz, unzip it.
  ftype="${1##*.}"
  if [[ $ftype == "tgz" ]];
  then
    mkdir "$2" && UnzipTar "$1" "$2"
  elif [[ $ftype == "gz" ]];
  then
    mkdir "$2" && UnzipTar "$1" "$2"
  elif [[ $ftype == "zip" ]];
  then
    mkdir "$2" && UnzipZip "$1" "$2"
  elif [[ $ftype == "7z" ]];
  then
    mkdir "$2" && Unzip7z "$1" "$2"
  else
    echo "filetype $ftype not suppose now pass" 
  fi
  # [[ ftype == "gz" ]] && mkdir "$2" && UnzipTar "$1" "$2"
}

for file in $(ls ./)
do
  final_dir=$(echo "$file" | cut -d "." -f1)
  RecognizeFileType "$file" "$final_dir"
done
