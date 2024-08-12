!/bin/bash

#cat bashrc.additions >> ~/.bashrc

#cp ./.gitmessage ~
#cp ./.gitconfig ~

# powerline fonts for zsh agnoster theme
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
cd .. && rm -rf fonts

# oh-my-zsh & plugins
wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O - | zsh || true

zsh -c 'git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions'
zsh -c 'git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting'
zsh -c 'git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions'

cp ./.zshrc ~

# Version de ZSH
version_actual=$(zsh --version | cut -d' ' -f2)
version_deseada="5.7.0"
if [ "$version_actual" > "$version_deseada" ]; then
  echo "La versión de zsh es la correcta."
  
  # powerlevel10k Requiere version 5.7
  if [ ! -d "$HOME"/.oh-my-zsh/custom/themes/powerlevel10k ]; then
    git clone --depth 1 https://github.com/romkatv/powerlevel10k "$HOME"/.oh-my-zsh/custom/themes/powerlevel10k
  fi
    
  cp ./.p10k.zsh ~
  # update theme
  sed -i '/^ZSH_THEME/c\ZSH_THEME="powerlevel10k/powerlevel10k"' ~/.zshrc
  
else
  echo "La versión de zsh es diferente."
fi

zsh -c 'source ~/.zshrc'