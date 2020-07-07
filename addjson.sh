#!/bin/sh

find $BASEDIR -maxdepth 1 -type d -name "aws-*"|while read b;do
echo "$b"
echo '{
"title": "My AWS Book",
"description": "AWS學習筆記分享!",
 "links" : {
    "sidebar" : {"Home" : "http://devopjj.com"  }
  }
}' > $b/book.json
done
