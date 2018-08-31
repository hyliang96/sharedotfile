
cd ~/.sharedotfile

push_share_dotfile()
{
	if ! [ -z "$(git status --porcelain)" ]; then
		git add -A  && \
		git commit -m "logout push"  && \
		git push origin master
	fi
}

push_share_dotfile & > .log/push.log

unset -f push_share_dotfile

