.PHONY: install sync diff

install:
	mkdir -p $(HOME)/.ssh
	mkdir -p $(HOME)/.ssh/config.d

	cp ./.ssh/config $(HOME)/.ssh/config
	cp ./.ssh/config.d/git $(HOME)/.ssh/config.d/git

	mkdir -p $(HOME)/.gitconfig.d
	cp ./.gitconfig $(HOME)/.gitconfig
	cp ./.gitconfig.d/gatech $(HOME)/.gitconfig.d/gatech
	cp ./.gitconfig.d/git $(HOME)/.gitconfig.d/git

	mkdir -p $(HOME)/.vscode
	cp ./.vscode/settings.json $(HOME)/.vscode/settings.json
	cp ./.vimrc $(HOME)/.vimrc

sync:
	cp $(HOME)/.ssh/config ./.ssh/config 
	cp -r $(HOME)/.gitconfig.d/* ./.gitconfig.d/
	cp $(HOME)/.vscode/settings.json ./.vscode/settings.json
	cp $(HOME)/.vimrc ./.vimrc 

diff:
