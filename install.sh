#!/bin/bash

for file in *
do
				ln --backup=t -s $PWD/$file ../\.${file##*/}
done
rm ../.README ../.install.sh
