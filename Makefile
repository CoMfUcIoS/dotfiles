
current_dir = $(shell pwd)

help: ## Shows this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

iNvim: ## Creates a symbolic link to the nvim config file and its plugins.
	@curl -fLo ./nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


iVim: ## Creates a symbolic link of vim folder in your home folder. Also backup your old .vim folder and .vimrc
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

uVim: ## Removes symbolic links and restores old configurations if available
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

iOhMyZSH: ## Installs Oh My Zsh if it doesnt exist, back up old configuration and links .zshrc
	@if [ ! command -v zsh &> /dev/null ]; \
		then \
 			$(error "Install ZSH first"); \
	fi
	@if [ -a ~/.oh-my-zsh ] ; \
		then \
			echo Backing up ..oh-my-zsh to ..oh-my-zsh.old; \
			mv ~/..oh-my-zsh ~/..oh-my-zsh.old; \
	fi;
	@if [ -a ~/.zshrc  ] ; \
		then \
			echo Backing up .zshrc to .zshrc.old; \
			mv ~/.zshrc ~/.zshrc.old; \
	fi;
	@if [ ! command -v curl &> /dev/null ]; \
		then \
 			echo "Curl isn't installed, trying wget"; \
		 	if [ ! command -v curl &> /dev/null ]; \
		 		then \
			 		echo "Also wget isn't install. Please install any of the above commands and try again"; \
				else \
					sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"; \
			fi; \
	else \
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"; \
 	fi;
	@echo Creating symbolic links
	@ln -sf $(current_dir)/zsh/zhsrc ~/.zhsrc
	@cp -r ~/.oh-my-zsh/custom/plugins/* $(current_dir)/zsh/custom/plugins
	@mv ~/.oh-my-zsh/custom/plugins ~/.oh-my-zsh/custom/plugins.old
	@ln -sf $(current_dir)/zsh/custom/plugins ~/.oh-my-zsh/custom/plugins
	@source ~/.zhsrc

iTmux: ## Creates a symbolic links for tmux
	@if [ -a ~/.tmux.conf ] ; \
		then \
			echo Backing up .tmux.conf to .tmux.conf.old; \
			mv ~/.tmux.conf ~/.tmux.conf.old; \
		fi;
	@if [ -a ~/.tmux  ] ; \
		then \
			echo Backing up .tmux folder to .tmux.old; \
			mv ~/.tmux ~/.tmux.old; \
		fi;
	@echo Creating symbolic links
	@ln -sf $(current_dir)/tmux.conf ~/.tmux.conf
	@cp -r ~/.tmux/plugins/* $(current_dir)/tmux/plugins
	@mv ~/.tmux/plugins ~/.tmux/plugins.old
	@ln -sf $(current_dir)/tmux/plugins ~/.tmux/plugins
	@echo installation finished.

.DEFAULT_GOAL: help

default: help

.PHONY: help
