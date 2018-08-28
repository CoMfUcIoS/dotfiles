
current_dir = $(shell pwd)

help: ## Shows this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

installVim: ## Creates a symbolic link of vim folder in your home folder. Also backup your old .vim folder and .vimrc
	@if [ -a ~/.vimrc ] ; \
		then \
			echo Backing up .vimrc to .vimrc.old; \
			mv ~/.vimrc ~/.vimrc.old; \
		fi;
	@if [ -a ~/.vim  ] ; \
		then \
			echo Backing up .vim folder to .vim.old; \
			mv ~/.vim ~/.vim.old; \
		fi;
	@echo Creating symbolic links
	@ln -sf $(current_dir)/vim ~/.vim
	@echo installation finished.

uninstallVim: ## Removes symbolic links and restores old configurations if available
	@echo uninstalling vim
	@rm ~/.vim
	@if [ -a ~/.vimrc.old ] ; \
		then \
			echo Restoring old .vimrc; \
			mv ~/.vimrc.old ~/.vimrc; \
		fi;
	@if [ -a ~/.vim.old  ] ; \
		then \
			echo Restoring .vim; \
			mv ~/.vim.old ~/.vim; \
		fi;
	@echo Uninstall of VIM done!

.DEFAULT_GOAL: help

default: help

.PHONY: help installVim uninstallVim
