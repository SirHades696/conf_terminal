#!/bin/bash
RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
NC='\033[0m'


if [ "$USER" = "root" ]; then
  printf "${RED}Please use \"sudo chown <normal user>:<normal user> install.sh\"${NC}\n"
else
  printf "${BLUE}																			"
  printf " 											"
  printf " 											"
  printf " 											"
  printf " 													     	 ██░ ██  ▄▄▄      ▓█████▄ ▓█████   ██████ 	"
  printf " 													     	▓██░ ██▒▒████▄    ▒██▀ ██▌▓█   ▀ ▒██    ▒ 	"
  printf " 													     	▒██▀▀██░▒██  ▀█▄  ░██   █▌▒███   ░ ▓██▄   	"
  printf " 													     	░▓█ ░██ ░██▄▄▄▄██ ░▓█▄   ▌▒▓█  ▄   ▒   ██▒	"
  printf " 													     	░▓█▒░██▓ ▓█   ▓██▒░▒████▓ ░▒████▒▒██████▒▒	"
  printf " 													     	 ▒ ░░▒░▒ ▒▒   ▓▒█░ ▒▒▓  ▒ ░░ ▒░ ░▒ ▒▓▒ ▒ ░	"
  printf " 													     	 ▒ ░▒░ ░  ▒   ▒▒ ░ ░ ▒  ▒  ░ ░  ░░ ░▒  ░ ░	"
  printf " 													     	 ░  ░░ ░  ░   ▒    ░ ░  ░    ░   ░  ░  ░  	"
  printf "  													     	 ░  ░  ░      ░  ░   ░       ░  ░      ░  	"
  printf " 													     					   ░                               	"
  printf "                      												"
  printf "${NC}\n"
  printf "${BLUE}Customize your terminal with colors and icons.${NC}\n"
  printf "${BLUE}This installer customizes the terminal by installing:\n"
  printf "${GREEN}  * Nerd Font (MesloLGS NF)\n"
  printf "  * Colors\n"
  printf "  * LSD \n"
  printf "  * Zsh \n"
  printf "  * Oh-My-Zsh\n"
  printf " * BatCat \n"
  printf "${BLUE}Author: ${GREEN}SirHades696${NC}\n"
  printf "${BLUE}Repo at: ${GREEN}https://github.com/SirHades696/conf_terminal/${NC}\n"

  printf "${GREEN}Press \"Y\" to continue: ${NC}"
  read key

  if [ "$key" = "Y" ] || [ "$key" = "y" ]; then

    printf "${GREEN}Checking requirements...${NC}\n"
    script_path=$(pwd)
    sudo apt-get update

    ###-----checking and installing packages
    # wget
    if ! [ -x "$(command -v wget)" ]; then
      printf "${RED}wget isn't installed${NC}\n"
      printf "${GREEN}Trying to install wget${NC}\n"
      sudo apt-get install wget -y
    fi

    # curl
    if ! [ -x "$(command -v curl)" ]; then
      printf "${RED}curl isn't installed${NC}\n"
      printf "${GREEN}Trying to install curl${NC}\n"
      sudo apt-get install curl -y
    fi

    # git
    if ! [ -x "$(command -v git)" ]; then
      printf "${RED}git isn't installed${NC}\n"
      printf "${GREEN}Trying to install git${NC}\n"
      sudo apt-get install git -y
    fi
    
    # BatCat
    if ! [ -x "$(command -v batcat)" ]; then
      printf "${RED}Batcat isn't installed${NC}\n"
      printf "${GREEN}Trying to install batcat${NC}\n"
      sudo apt install bat -y
      mkdir -p ~/.local/bin
      ln -s /usr/bin/batcat ~/.local/bin/bat
    fi

    # Ruby (GEM)
    if ! [ -x "$(command -v gem)" ]; then
      printf "${RED}ruby isn't installed${NC}\n"
      printf "${GREEN}Trying to install ruby and others dependences${NC}\n"
      sudo apt-get install build-essential patch ruby-dev zlib1g-dev liblzma-dev ruby-full -y
    fi

    # Nerd Fonts
    if ! [ -f ~/.local/share/fonts/MesloLGS\ NF\ Regular.ttf ]; then
      printf "${GREEN}Downloading Meslo Nerd Font${NC}\n"
      wget https://github.com/SirHades696/conf_terminal/raw/main/NerdFonts/MesloLGS%20NF%20Bold%20Italic.ttf
      wget https://github.com/SirHades696/conf_terminal/raw/main/NerdFonts/MesloLGS%20NF%20Bold.ttf
      wget https://github.com/SirHades696/conf_terminal/raw/main/NerdFonts/MesloLGS%20NF%20Italic.ttf
      wget https://github.com/SirHades696/conf_terminal/raw/main/NerdFonts/MesloLGS%20NF%20Regular.ttf
      MF=$script_path/MesloLGS\ NF\ Regular.ttf
      if [ -f "$MF" ]; then
        printf "${GREEN}Installing Meslo Nerd Font${NC}\n"
        if ! [ -d ~/.local/share/fonts/ ]; then
          mkdir -p ~/.local/share/fonts/
        fi
        mv $script_path/*.ttf ~/.local/share/fonts/
        fc-cache -fv
      fi
    fi

    # Afet install gem, install colorls
    if [ -x "$(command -v gem)" ]; then
      if ! [ -x "$(command -v colorls)" ]; then
        printf "${GREEN}Installing Colorls${NC}\n"
        sudo gem install colorls
      fi
      if [ gem list colorls -i ]; then
        source $(dirname $(gem which colorls))/tab_complete.sh
        cp $(dirname $(gem which colorls))/yaml ~/.config/colorls
      fi
    fi

    # LSD
    if ! [ -x "$(command -v lsd)" ]; then
      printf "${RED}lsd isn't installed${NC}\n"
      printf "${GREEN}Trying to install lsd${NC}\n"
      wget https://github.com/Peltoche/lsd/releases/download/0.22.0/lsd-musl_0.22.0_amd64.deb
      sudo dpkg -i lsd-musl_0.22.0_amd64.deb
    fi
    
    # Zsh
    if ! [ -x "$(command -v zsh)" ]; then
      printf "${RED}zsh isn't installed${NC}\n"
      printf "${GREEN}Trying to install zsh${NC}\n"
      sudo apt-get install zsh -y
    fi
    # Zsh with oh-my-zsh and plugins
    if [ -x "$(command -v zsh)" ]; then
      if [ "$SHELL" != "/usr/bin/zsh" ]; then
        printf "${RED}Zsh isn't set as shell\n"
        printf "${GREEN} Trying to set Zsh as shell\n${NC}"
        sudo chsh -s $(which zsh) $(whoami)
      fi
      if ! [ -d ~/.oh-my-zsh/ ]; then
        printf "${GREEN}Installing Oh-My-Zsh${NC}\n"
        wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
        cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
        touch ~/.zsh_history
      fi
      if [ -d ~/.oh-my-zsh/plugins/ ]; then
        cd ~/.oh-my-zsh/plugins/
        if ! [ -d ~/.oh-my-zsh/plugins/zsh-autocomplete/ ]; then
          printf "${GREEN}Installing Zsh-autocomplete${NC}\n"
          git clone https://github.com/marlonrichert/zsh-autocomplete.git
        fi
        if ! [ -d ~/.oh-my-zsh/plugins/zsh-autosuggestions/ ]; then
          printf "${GREEN}Installing Zsh-Autosuggestions${NC}\n"
          git clone https://github.com/zsh-users/zsh-autosuggestions
        fi
        if ! [ -d ~/.oh-my-zsh/plugins/zsh-syntax-highlighting/ ]; then
          printf "${GREEN}Installing Zsh-syntax-highlighting${NC}\n"
          git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
        fi
        if ! [ -d ~/.oh-my-zsh/plugins/git-flow-completion/ ]; then
          printf "${GREEN}Installing Git-flow-completion${NC}\n"
          git clone https://github.com/bobthecow/git-flow-completion.git
        fi
      fi
    fi
    
    # Powerlevel10k
    if ! [ -d ~/.oh-my-zsh/custom/themes/powerlevel10k/ ]; then
      printf "${RED}Powelevel10k theme isn't installed${NC}\n"
      printf "${GREEN}Trying to install Powerlevel10k theme${NC}\n"
      git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    fi

    # Remplacing original files with SirHades696 conf
    if [ -f ~/.zshrc ]; then
      cd ~
      printf "${GREEN}Adding conf of SirHades696 in your terminal (GNOME-TERMINAL)${NC}\n"
      wget https://github.com/SirHades696/conf_terminal/raw/main/gnome-terminal-profiles.dconf
      dconf load /org/gnome/terminal/legacy/profiles:/ < gnome-terminal-profiles.dconf
      mv .zshrc .zshrc.original_file
      wget https://github.com/SirHades696/conf_terminal/raw/main/.zshrc
      
      if [ -f ~/.p10k.zsh ]; then
        mv .p10k.zsh .p10k.original_file
      fi
      wget https://github.com/SirHades696/conf_terminal/raw/main/.p10k.zsh
      
      if [ -f ~/.config/colorls/dark_colors.yaml ]; then
        cd ~/.config/colorls/
        mv dark_colors.yaml dark_colors.original_file
        wget https://github.com/SirHades696/conf_terminal/raw/main/colorls/dark_colors.yaml
      fi

    fi
    
    # Tilix conf
    if [ -f ~/.zshrc ] && ! [ $TILIX_ID ] ; then
      printf "${RED}Optional conf${NC}\n"
      printf "${BLUE}Tilix not found, removing conf for Tilix${NC}\n"
      sed -i "$(($(wc -l < ~/.zshrc)-4)),\$d" ~/.zshrc
    fi
    # ----- checking packages
    # wget
    if ! [ -x "$(command -v wget)" ]; then
      printf "${RED}wget installation failed ${NC}\n"
    else
      printf "${GREEN}wget - OK${NC}\n"
    fi

    # curl
    if ! [ -x "$(command -v curl)" ]; then
      printf "${RED}curl installation failed${NC}\n"
    else
      printf "${GREEN}curl - OK${NC}\n"
    fi

    # git
    if ! [ -x "$(command -v git)" ]; then
      printf "${RED}git installation failed${NC}\n"
    else
      printf "${GREEN}git - OK${NC}\n"
    fi
    
    # ruby (gem)
    if ! [ -x "$(command -v gem)" ]; then
      printf "${RED}ruby installation failed${NC}\n"
    else
      printf "${GREEN}ruby - OK${NC}\n"
    fi

    # Colorls
    if ! [ -x "$(command -v colorls)" ]; then
      printf "${RED}colorls installation failed${NC}\n"
    else
      printf "${GREEN}colorls - OK${NC}\n"
    fi
    
    # LSD
    if ! [ -x "$(command -v lsd)" ]; then
      printf "${RED}lsd installation failed${NC}\n"
    else
      printf "${GREEN}lsd - OK${NC}\n"
    fi
    
    # Batcat
    if ! [ -x "$(command -v batcat)" ]; then
      printf "${RED}Batcat installation failed${NC}\n"
    else
      printf "${GREEN}Batcat - OK${NC}\n"
    fi

    # ZSH
    if ! [ -x "$(command -v zsh)" ]; then
      printf "${RED}zsh installation failed${NC}\n"
    else
      printf "${GREEN}zsh - OK${NC}\n"
    fi
    
    # Oh-My-Zsh
    if [ -d ~/.oh-my-zsh/ ]; then
      printf "${GREEN}Oh-My-Zsh - OK${NC}\n"
      
      # Zsh-autocomplete
      if [ -d ~/.oh-my-zsh/plugins/zsh-autocomplete/ ]; then
        printf "${GREEN}Zsh-autocomplete - OK${NC}\n"
      else
        printf "${RED}Zsh-autocomplete installation failed${NC}\n"
      fi
      
      # zsh-autosuggestions
      if [ -d ~/.oh-my-zsh/plugins/zsh-autosuggestions/ ]; then
        printf "${GREEN}Zsh-autosuggestions - OK${NC}\n"
      else
        printf "${RED}Zsh-Autosuggestions installation failed${NC}\n"
      fi
      
      # Zsh-syntax-highlighting
      if [ -d ~/.oh-my-zsh/plugins/zsh-syntax-highlighting/ ]; then
        printf "${GREEN}Zsh-syntax-highlighting - OK${NC}\n"
      else
        printf "${RED}Zsh-syntax-highlighting installation failed${NC}\n"
      fi
      
      # Git-flow-completion
      if [ -d ~/.oh-my-zsh/plugins/git-flow-completion/ ]; then
        printf "${GREEN}Git-flow-completion - OK${NC}\n"
      else
        printf "${RED}Git-flow-completion installation failed${NC}\n"
      fi
      
      if [ -d ~/.oh-my-zsh/custom/themes/powerlevel10k/ ]; then
        printf "${GREEN}Powerlevel10K - OK${NC}\n"
      else
        printf "${RED}Powelevel10k installation failed${NC}\n"
      fi

      # Nerd Font
      FP=~/.local/share/fonts/MesloLGS\ NF\ Regular.ttf
      if [ -f "$FP" ]; then
        printf "${GREEN}MesloLGS NF is installed, please set this font in your Terminal${NC}\n"
        printf "${GREEN}Edit>Preferences>Profile>Custom Font>${BLUE}MesloLGS NF Regular${NC}\n"
      else
        printf "${RED}Meslo font isn't installed${NC}\n"
      fi
      else
        printf "${RED}Oh-My-Zsh installation failed${NC}\n"
      fi
      printf "${BLUE}Please log out from the current shell then log back in for see results.${NC}\n"

  else
    
    printf "\n${BLUE}Good bye!!${NC}\n"
  
  fi
fi


