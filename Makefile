
current_dir = $(shell pwd)

help: ## Shows this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

.SILENT:
install_nvim: ## Creates a symbolic link to the nvim config file and its plugins.
	if [ -a ~/.config/nvim ] ; \
		then \
			echo backing up old nvim folder to nvim.old; \
			mv ~/.config/nvim ~/.config/nvim.old; \
		fi;
	echo Creating symbolic links
	ln -sf $(current_dir)/nvim ~/.config/nvim
	echo Installation done.


uninstall_nvim: ## Removes symbolic links and restores old configurations if available
	echo uninstalling nvim
	rm ~/.config/nvim
	if [ -a ~/.config/nvim.old ] ; \
		then \
			echo Restoring old nvim config; \
			mv ~/.config/nvim.old ~/.config/nvim; \
		fi;
	echo Uninstall of NVIM done!

install_OhMyZSH: ## Installs Oh My Zsh if it doesnt exist, back up old configuration and links .zshrc
	if [ ! command -v zsh &> /dev/null ]; \
		then \
 			$(error "Install ZSH first"); \
	fi
	if [ -a ~/.oh-my-zsh ] ; \
		then \
			echo Backing up ..oh-my-zsh to ..oh-my-zsh.old; \
			mv ~/..oh-my-zsh ~/..oh-my-zsh.old; \
	fi;
	if [ -a ~/.zshrc  ] ; \
		then \
			echo Backing up .zshrc to .zshrc.old; \
			mv ~/.zshrc ~/.zshrc.old; \
	fi;
	if [ ! command -v curl &> /dev/null ]; \
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
	echo Creating symbolic links
	ln -sf $(current_dir)/zsh/zhsrc ~/.zhsrc
	echo fetching plugins
	if [ -a ]
	git clone https://github.com/sobolevn/wakatime-zsh-plugin.git wakatime
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  git clone https://github.com/larkery/zsh-histdb ~/.oh-my-zsh/custom/plugins/zsh-histdb
  zsh-autosuggestions
	mv ~/.oh-my-zsh/custom/plugins ~/.oh-my-zsh/custom/plugins.old
	ln -sf $(current_dir)/zsh/custom/plugins ~/.oh-my-zsh/custom/plugins
	source ~/.zhsrc

install_Tmux: ## Creates a symbolic links for tmux
	if [ -a ~/.tmux.conf ] ; \
		then \
			echo Backing up .tmux.conf to .tmux.conf.old; \
			mv ~/.tmux.conf ~/.tmux.conf.old; \
		fi;
	if [ -a ~/.tmux  ] ; \
		then \
			echo Backing up .tmux folder to .tmux.old; \
			mv ~/.tmux ~/.tmux.old; \
		fi;
	echo Creating symbolic links
	ln -sf $(current_dir)/tmux.conf ~/.tmux.conf
	ln -sf $(current_dir)/tmux/plugins ~/.tmux
	echo installation finished.

.DEFAULT_GOAL: help

.PHONY: help install_nvim install_OhMyZSH install_Tmux uninstall_nvim
