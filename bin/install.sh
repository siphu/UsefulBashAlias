#!/bin/bash


# location of where all the alias files will be stored
destinationDir="$HOME/.sources"

# pattern to determine if .alias link has been injected
aliasPattern="if [ -f \$HOME/.alias ]; then . \$HOME/.alias; fi"

# order of the rc file to inject loading of the alias
rcFiles=(
		"$HOME/.zshrc"
		"$HOME/.bash_profile"
		"$HOME/.bashrc"
	  )


# source alias folder from github repo
sourceDir="https://raw.githubusercontent.com/siphu/UsefulBashAlias/main/sources"

# alias file avaliable on the github repo
files=(
	"files"
	"rsub"
	)



# clean out the folder and .alias file
mkdir -p "$destinationDir"
rm -rf $HOME/.alias


for i in "${files[@]}"
do
	echo "Downloading: $i"
	wget -q "$sourceDir/$i" -O "$destinationDir/$i"
	echo ". $destinationDir/$i" >> $HOME/.alias
done


# inject calling of the .alias file
for i in "${rcFiles[@]}"
do
	if [ -f $i ]; then
		if [ `grep -Fq "$aliasPattern" $i > /dev/null; echo $?`  == 1 ];  then
			echo -e "\n$aliasPattern\n" >> $i
		fi
		. $i #this doesnt work
		break
	fi
done
