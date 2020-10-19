mkdir -p ~/.sources
wget https://raw.githubusercontent.com/siphu/UsefulBashAlias/main/sources/files -O ~/.sources/files

rm -rf ~/.alias
echo ". ~/.sources/files" > ~/.alias

if [ -f ~/.zshrc ] && ! [ grep -Fxq "if [ -f ~/.alias ]; then . ~/.alias; fi" ~/.zshrc ]; then 
   echo "if [ -f ~/.alias ]; then . ~/.alias; fi" >> ~/.zshrc
  . ~/.zshrc
elif [ -f ~/.bash_profile ] && ! [ grep -Fxq "if [ -f ~/.alias ]; then . ~/.alias; fi" ~/.bash_profile ]; then
  echo "if [ -f ~/.alias ]; then . ~/.alias; fi" >> ~/.bash_profile
  . ~/.bash_profile
fi

