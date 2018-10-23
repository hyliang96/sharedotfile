

cd ~/.sharedotfile

{
if ! [ -z "$(git status --porcelain)" ]; then
	git add -A && \
	git commit -m "logout push" --quiet && \
	git push origin master --quiet;
fi;
}&

