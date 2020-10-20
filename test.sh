#!/bin/sh
rcFiles="$HOME/.zshrc $HOME/.bash_profile $HOME/.bashrc $HOME/.profile"
for m in $rcFiles
do
	echo "m: $m"
done