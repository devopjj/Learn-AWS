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


git checkout gh-pages
cp -r _book/* .

#git push -u origin gh-pages
git checkout master
done

# commit master
cd $BASEDIR
git checkout master
git add .
git commit -m $1
git push -u origin master

# commit gh-pages
cd $BASEDIR
git checkout gh-pages
git add .
git commit -m $1
git push -u origin gh-pages