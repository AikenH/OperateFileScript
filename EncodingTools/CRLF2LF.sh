#!/bin/bash
usage()
{
  printf "Usage: %s [ -l | -c | -b | -u] \n" ${0##*/}
  printf "[-l] change CRLF2LF recursively in current directory\n"
  printf "[-c] change LF2CRLF recursively in current directory\n"
  printf "[-u] change bom2unbom recursively in current directory\n"
  printf "[-b] change unbom2bom recursively in current directory\n"

}

no_args="true"
while getopts ":lcub" opt;
do
  case "$opt" in
    l)
      echo "Excute change CRLF2LF"
      sudo find . -type f -exec dos2unix {} \;
      ;;
    c)
      echo "Excute change LF2CRLF"
      sudo find . -type f -exec unix2dos {} \;
      ;;
    u)
      echo "Excute change unbom2BOM recursively in current directory"
      list=$(grep -r -I -l $'^\xEF\xBB\xBF' ./)
      for x in $list;
      do
        echo "$x"
        sudo sed -i 's/\xEF\xBB\xBF//' "$x"
      done
      ;;
    b)
      echo "Excute change bom2unbom recursively in current directory"
      list=$(grep -r -I -l -v $'^\xEF\xBB\xBF' ./)
      for x in $list;
      do
        echo "$x"
        sudo sed -i '1 s/^/\xEF\xBB\xBF&/' "$x"
      done
    exit 0;;

    :)
      usage
      echo "Excute nothing now for unknown option"
      exit 1
      ;;
    \?)
      usage
      echo "Excute nothing now for unknown option"
      exit 1
      ;;
  esac
  no_args="false"
done

[[ "$no_args" == "true" ]] && { usage; exit 1; }
