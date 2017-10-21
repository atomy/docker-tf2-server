#!/bin/bash

OUT=""

while IFS= read -r LINE;
do
  OUT="${OUT} --build-arg ${LINE}"
done < build/env

OUT="${OUT} --build-arg LOCAL_USER_ID=`id -u`"
OUT="${OUT} --build-arg LOCAL_GROUP_ID=`id -g`"

echo ${OUT}
