.PHONY: install sync diff

install:
	mkdir -p $(HOME)/.config/kitty
	cp ./kitty.conf $(HOME)/.config/kitty/kitty.conf
	cp ./ssh.config $(HOME)/.config/kitty/ssh.conf
	mkdir -p $(HOME)/.config/kitty/ssh/
	cp -r ./ssh/* $(HOME)/.config/kitty/ssh/

sync:
	cp $(HOME)/.config/kitty/kitty.conf ./kitty.conf
	cp $(HOME)/.config/kitty/ssh.conf ./ssh.conf
	cp -r $(HOME)/.config/ssh/* ./ssh

diff:
	