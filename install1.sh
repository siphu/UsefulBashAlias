#!/bin/bash

# location to where the basher executable and config will be stored
destination="$HOME/.basher"

# script name
basher="$destination/basher"

# source repo (raw content)
sourceGit="https://raw.githubusercontent.com/siphu/basher/develop"


rm -rf "$destination"

main() {

	setup_color

	# create the folder
	mkdir -p "$destination"

	bashUrl="$sourceGit/bin/basher"
	result=`wget -q -S --spider $bashUrl  2>&1`

	if  validateUrl $bashUrl; then
		downloadBasher $bashUrl
		injectRC
	else
		echo "ERROR: Unable to find basher source file"
		exit 1
	fi


}

setup_color() {
	# Only use colors if connected to a terminal
	if [ -t 1 ]; then
		RED=$(printf '\033[31m')
		GREEN=$(printf '\033[32m')
		YELLOW=$(printf '\033[33m')
		BLUE=$(printf '\033[34m')
		BOLD=$(printf '\033[1m')
		RESET=$(printf '\033[m')
	else
		RED=""
		GREEN=""
		YELLOW=""
		BLUE=""
		BOLD=""
		RESET=""
	fi
}


error() {
	echo ${RED}"Error: $@"${RESET} >&2
}


validateUrl() {
  if curl --output /dev/null --silent --head --fail "$1"
  	then return 0
	else return 1
  fi
}


downloadBasher()
{
	wget -q "$1" -O "$basher"
	chmod +x "$basher"
}


injectRC()
{
	exportPath="export PATH=\$PATH:$destination"

	rcFiles=(
			"$HOME/.zshrc"
			"$HOME/.bash_profile"
			"$HOME/.bashrc"
			"$HOME/.profile"
		  )

	for i in "${rcFiles[@]}"
	do
		if [ -f $i ]; then
			if [ `grep -Fq "$exportPath" $i > /dev/null; echo $?`  == 1 ];  then
				echo -e "\n$exportPath\n" >> $i
			fi
			export PATH=$PATH:$destination
			export PHU=TEST
			break
		fi
	done


}


main