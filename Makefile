# Define config directory
XDG_CONFIG_HOME ?= $(HOME)/.config

# List all files to be installed
CONF_FILES := $(wildcard $(PWD)/config/*)
HOME_FILES := $(wildcard $(PWD)/home/*) \
	      $(filter-out $(PWD)/home/. $(PWD)/home/.., \
	      $(wildcard $(PWD)/home/.*))

install:
	@echo "Installing files to $(HOME)..."
	@cp -v $(HOME_FILES) $(HOME)
	@echo "Home files installed."
	@echo "Installing config files to $(XDG_CONFIG_HOME)..."
	@cp -vr $(CONF_FILES) $(XDG_CONFIG_HOME)
	@echo "Config files installed."

uninstall:
	@echo "Uninstalling files from $(HOME)..."
	@for file in $(HOME_FILES); do \
		rm -rf $(HOME)/$$(basename $$file); \
	done
	@echo "Home files uninstalled."
	@echo "Uninstalling files from $(XDG_CONFIG_HOME)"
	@for file in $(CONF_FILES); do \
		rm -rf $(XDG_CONFIG_HOME)/$$(basename $$file); \
	done
	@echo "Config files uninstalled."

list:
	@echo "Files to be installed to $(HOME):"
	@echo "Home directory files:"
	@for file in $(HOME_FILES); do \
		echo $$file; \
	done
	@echo "Files to be installed to $(XDG_CONFIG_HOME):"
	@for file in $(CONF_FILES); do \
		echo $$file; \
	done
