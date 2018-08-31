

cd ~/.sharedotfile


	if ! [ -z "$(git status --porcelain)" ]; then
		git add -A &> ~/.sharedotfile_log/push.log
		git commit -m "logout push" &>> ~/.sharedotfile_log/push.log
		git push origin master &>> ~/.sharedotfile_log/push.log
	fi
