.PHONY: install sync diff

install:
	mkdir -p $(HOME)/.zsh
	mkdir -p $(HOME)/.zsh/aliases
	cp -r ./aliases/* $(HOME)/.zsh/aliases/
	mkdir -p $(HOME)/.zsh/env
	cp -r ./env/* $(HOME)/.zsh/env/
	mkdir -p $(HOME)/.zsh/fraugman
	cp -r ./fraugman/* $(HOME)/.zsh/fraugman/
	mkdir -p $(HOME)/.zsh/functions
	cp -r ./functions/* $(HOME)/.zsh/functions/
	mkdir -p $(HOME)/.zsh/tools
	cp -r ./tools/* $(HOME)/.zsh/tools/
	cp .zshrc $(HOME)/.zshrc

sync:
	cp -r $(HOME)/.zsh/aliases/* ./aliases/ 
	cp -r $(HOME)/.zsh/env/* ./env/
	cp -r $(HOME)/.zsh/fraugman/* ./fraugman/
	cp -r $(HOME)/.zsh/functions/* ./functions/ 
	cp -r $(HOME)/.zsh/tools/* ./tools/ 
	cp $(HOME)/.zshrc .zshrc 

diff:
