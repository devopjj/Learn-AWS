#!/bin/bash
BASEDIR=$(dirname "$0")
if [ $BASEDIR == "." ];then
BASEDIR=`pwd`
fi


# build gitbook
git checkout master

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
# build gh-pages
git checkout gh-pages

# add gitbook to gh-pages
find $BASEDIR -maxdepth 1 -type d -name "book_*"|while read b;do
cd $b
# clear cache ,temp
git rm --cached -r .
git clean -df
rm -rf *~

git add .
cp -r _book/* .
bookname=`echo ${b#*$BASEDIR/}`
tag=`date '+%Y%m%d %H:%M'`
git commit -m "$bokname generate on $tag"
done

# push gh-pages
git add .
tag=`date '+%Y%m%d %H:%M'`
git commit -m " gh-pages build at $tag"
git push -u origin gh-pages

git checkout master