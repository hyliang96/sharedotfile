
cd ~/.sharedotfile
{
	if ! [ -z "$(git status --porcelain)" ]; then
   	git add -A  && \
	git commit -m "logout push" && \
	git push origin master
fi;
}&
