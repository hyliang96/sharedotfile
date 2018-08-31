# sharedotfile
the shared dotfiles among all my servers, mac and cp (WSL)

### install
* git clone this repo to a new computer, put the dir on any path you like

* make soft links from $HOME to  all the dotfiles under this dir  (expect .git) 
```bash
cd ~
ln -s `echo ~/.sharedotfile/.* | grep -v .git`  .
```

* make soft link from your script dir to all the visible files under this dir (expect README.md)
```bash
cd /path/to/your/scripts/
ln -s `echo ~/.sharedotfile/* | grep  -v README.md` .
```

### use
#### manully
* pull : `./pulldotfile.sh`
* push all change:	`./pushdotfile.sh`

#### automatically
* git pull it when you login a computer 
* git push it when you logout the computer
