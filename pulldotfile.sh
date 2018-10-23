

cd ~/.sharedotfile
git pull origin master --quiet &

echo before . ~/.bash_aliases
. ~/.bash_aliases
echo after . ~/.bash_aliases
