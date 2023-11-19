.PHONY: install sync diff

install:
	$(MAKE) -C init install
	$(MAKE) -C home install
	$(MAKE) -C zsh install
	$(MAKE) -C kitty install

sync:
	$(MAKE) -C home sync
	$(MAKE) -C zsh sync
	$(MAKE) -C kitty sync