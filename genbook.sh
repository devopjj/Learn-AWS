#!/bin/bash
BASEDIR=$(dirname "$0")
if [ $BASEDIR == "." ];then
BASEDIR=`pwd`
fi


git checkout master

# build gitbook
find $BASEDIR -maxdepth 1 -type d -name "book_*"|while read b;do
cd $b
gitbook build
cd $BASEDIR
git add .
bookname=`echo ${b#*$BASEDIR/}`
tag=`date '+%Y%m%d %H:%M'`
git commit -m "$bookname,gitbook build at $tag"
done

# push master
git push -u origin master
exit 1
git checkout gh-pages
# add gitbook to gh-pages
find $BASEDIR -maxdepth 1 -type d -name "book_*"|while read b;do
cd $b
git add .
cp -r _book/* .
git commit -m "$b,gitbook buil"
done

# push gh-pages
git push -u origin gh-pages