
cd ~/.sharedotfile

{
	if ! [ -z "$(git status --porcelain)" ]; then
		git add -A   > .log/push.log && \
		git commit -m "logout push" >> .log/push.log  && \
		git push origin master  >> .log/push.log
	fi;
} & 
