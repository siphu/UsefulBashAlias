#!/bin/bash

# location to where the basher executable and config will be stored
destination="$HOME/.basher"

# source repo (raw content)
sourceGit="https://raw.githubusercontent.com/siphu/basher/develop"


# create the folder
mkdir -p "$destination"


result= wget -O /dev/null -q "$sourceGit/bin/basher"

if [result]; then
	echo "YAY"
elif
	echo "FILE DOES NOT EXISTS"
end
