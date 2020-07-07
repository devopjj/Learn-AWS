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
git commit -m "$b,gitbook buil"
done

exit 1
# push master
git push -u origin master

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