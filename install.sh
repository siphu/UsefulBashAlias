#!/bin/sh
#####
#
# This script downloads basher and places it a new $PATH location
# This can be ran via -
#
# wget -
# 	source <(wget -O- https://raw.githubusercontent.com/siphu/basher/develop/install.sh)
# Curl
# 	source <(curl -fsSL https://raw.githubusercontent.com/siphu/basher/develop/install.sh)



#default settings
destination="$HOME/.basher"   # folder where .basher will install to
basher="$destination/basher"  # script name
sourceGit="https://raw.githubusercontent.com/siphu/basher/develop" # source repo (raw content)


#testing purpose
rm -rf "$destination"


main() {

	# create the folder
	mkdir -p "$destination"

	bashUrl="$sourceGit/bin/basher"
	result=`wget -q -S --spider $bashUrl  2>&1`

	if  validate_url $bashUrl; then
		download_basher $bashUrl
		inject_rc
		echo "Basher installed at: $basher"
	else
		echo "ERROR: Unable to find basher source file"
		exit 1
	fi


}

validate_url() {
  if curl --output /dev/null --silent --head --fail "$1"
  	then return 0
	else return 1
  fi
}

download_basher()
{
	wget -q "$1" -O "$basher"
	chmod +x "$basher"
}

inject_rc()
{
	exportPath="export PATH=\$PATH:$destination"
	rcFiles="$HOME/.zshrc $HOME/.bash_profile $HOME/.bashrc $HOME/.profile"

	for i in $rcFiles
	do
		if [ -f $i ]; then
			if ! grep -Fxq "$exportPath" $i
			then
				echo "$exportPath" >> $i
				export PATH=$PATH:$destination
			fi
			break
		fi
	done


}


main
