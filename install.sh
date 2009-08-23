#!/bin/bash

for file in *
do
				ln --backup=t -s $PWD/$file $HOME/\.${file##*/}
done
rm $HOME/.README $HOME/.install.sh
