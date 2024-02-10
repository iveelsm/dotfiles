.PHONY: install sync diff

install:
	mkdir -p $(HOME)/.ssh
	cp ./.ssh/config $(HOME)/.ssh/config
	mkdir -p $(HOME)/.ssh/config.d/
	cp -r ./.ssh/config.d/* $(HOME)/.ssh/config.d/
	mkdir -p $(HOME)/.vscode
	cp ./.vscode/settings.json $(HOME)/.vscode/settings.json
	cp ./.vimrc $(HOME)/.vimrc

sync:
	cp $(HOME)/.ssh/config ./.ssh/config 
	cp $(HOME)/.vscode/settings.json ./.vscode/settings.json
	cp $(HOME)/.vimrc ./.vimrc 

diff:
