#!/bin/bash

title=`echo $1 | tr "A-Z" "a-z"`
title=`echo $title | tr " " "-"`
title=`echo $title | sed "s/\.//g"`
hugo new post/"`date +%Y-%m-%d`-$title.markdown"
