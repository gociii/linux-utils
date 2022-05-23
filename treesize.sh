#!/bin/bash
echo
while [ -n "$1" ]
do
    case "$1" in
        -c) countItems=true; itemCountDesc="with ItemCount" ;;
        *) echo "$1 is not an option" ;;
    esac
shift
done

echo treesize at `date +"%Y-%m-%d %H:%M:%S"` $itemCountDesc for `pwd`
echo

AWK_OUT=`du -k --max-depth=1 | sort -nr | awk '
BEGIN {
  split ("KB,MB,GB,TB", Units, ",");
}

{
  u = 1;
  while ($1 >= 1024) {
    $1 = $1 / 1024;
    u += 1
  }
  $1 = sprintf("% *s%.1f %s", (8-length(sprintf("%.1f", $1))), " ", $1, Units[u]);

  printf $0 "//";

}
'`
#Remove last 2-character delimiter
AWK_OUT=${AWK_OUT::-2}

d="//"
printf '%s\n' "${AWK_OUT//$d/$'\n'}" | sed 1d | \
while read i
do
#  tmp=${i#*.}
  #tmp=${tmp#*.}

  if [ "$countItems" = true ]; then
    i=$i `find .$tmp -type f | wc -l`
  fi

  echo $i
  #printf '| %8s\n |' $line
done

echo
echo Total items: `find . -type f | wc -l`
echo
