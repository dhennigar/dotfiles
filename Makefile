XDG_CONFIG_HOME ?= $(HOME)/.config
DOTFILES_HOME := home
DOTFILES_CONFIG := config

install:
	@echo "Installing dotfiles..."
	# Symlink files from 'home' to $HOME
	for file in $(DOTFILES_HOME)/*; do \
		target="$(HOME)/$$(basename $$file)"; \
		if [ -e "$$target" ] && [ ! -L "$$target" ]; then \
			echo "Conflict: $$target already exists and is not a symlink. Skipping."; \
		else \
			ln -svf "$(PWD)/$$file" "$$target"; \
		fi; \
	done
	# Symlink directories from 'config' to $XDG_CONFIG_HOME
	for dir in $(DOTFILES_CONFIG)/*; do \
		target="$(XDG_CONFIG_HOME)/$$(basename $$dir)"; \
		if [ -e "$$target" ] && [ ! -L "$$target" ]; then \
			echo "Conflict: $$target already exists and is not a symlink. Skipping."; \
		else \
			ln -svf "$(PWD)/$$dir" "$$target"; \
		fi; \
	done
	@echo "Dotfiles installed successfully."

uninstall:
	@echo "Uninstalling dotfiles..."
	# Remove symlinks from $HOME
	for file in $(DOTFILES_HOME)/*; do \
		target="$(HOME)/$$(basename $$file)"; \
		if [ -L "$$target" ]; then \
			rm -v "$$target"; \
		else \
			echo "No symlink found for $$target. Skipping."; \
		fi; \
	done
	# Remove symlinked directories from $XDG_CONFIG_HOME
	for dir in $(DOTFILES_CONFIG)/*; do \
		target="$(XDG_CONFIG_HOME)/$$(basename $$dir)"; \
		if [ -L "$$target" ]; then \
			rm -v "$$target"; \
		else \
			echo "No symlink found for $$target. Skipping."; \
		fi; \
	done
	@echo "Dotfiles uninstalled successfully."

.PHONY: install uninstall
