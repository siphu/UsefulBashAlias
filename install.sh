#!/bin/bash

# location to where the basher executable and config will be stored
destination="$HOME/.basher"

# script name
basher="$destination/basher"

# source repo (raw content)
sourceGit="https://raw.githubusercontent.com/siphu/basher/develop"


rm -rf "$destination"



main() {


	# create the folder
	mkdir -p "$destination"

	bashUrl="$sourceGit/bin/basher"
	result=`wget -q -S --spider $bashUrl  2>&1`

	if  validateUrl $bashUrl; then
		downloadBasher $bashUrl
		injectRC
		echo "Basher installed to: $basher"
	else
		echo "ERROR: Unable to find basher source file"
		exit 1
	fi




}


function validateUrl() {
  if [[ `wget -S --spider $1  2>&1 | grep 'HTTP/1.1 200 OK'` ]];
  	then return 0
	else return 1
  fi
}


function downloadBasher()
{
		wget -q "$1" -O "$basher"
		chmod +x "$basher"
}


function injectRC()
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
			`$exportPath`
			break
		fi
	done


}


main