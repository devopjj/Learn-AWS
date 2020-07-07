#!/bin/bash
BASEDIR=$(dirname "$0")
if [ $BASEDIR == "." ];then
BASEDIR=`pwd`
fi


# build gitbook
git checkout master

find $BASEDIR -maxdepth 1 -type d -name "mormoraws-*"|while read b;do
cd $b
gitbook build
git add .
bookname=`echo ${b#*$BASEDIR/}`
tag=`date '+%Y%m%d %H:%M'`
git commit -m "$bookname,gitbook build at $tag"
done

# push master
git push -u origin master



# build gh-pages
git checkout gh-pages
git add .
# add gitbook to gh-pages
find $BASEDIR -maxdepth 1 -type d -name "aws-*"|while read b;do
cd $b
# clear cache ,temp
git rm --cached -r .
git clean -df
rm -rf *~

cp -r _book/* .
git add .
bookname=`echo ${b#*$BASEDIR/}`
tag=`date '+%Y%m%d %H:%M'`
git commit -m "$bokname generate on $tag"
done

# push gh-pages
git push -u origin gh-pages

git checkout master