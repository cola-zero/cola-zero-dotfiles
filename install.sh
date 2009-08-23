#!/bin/bash
for file in ./
do
				ln --backup=t -s $file ../\.${file##*/}
done
