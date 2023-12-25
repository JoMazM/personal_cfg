#!/bin/bash
mkdir -p ~/bin
cd bin
# Requires different tools
# sudo apt install curl libfuse2 ripgrep fd-find fzf python3-pip git
# ln -s $(which fdfind) ~/.local/bin/fd


############################
#     Nerd font
############################
FILE=~/.local/share/fonts/BlexMonoNerdFontMono-Regular.ttf
if [ -f "$FILE" ]; then
    echo "$FILE exist. Not updated"
else 
    echo "$FILE does not exist. Installing .."
    
    curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/IBMPlexMono.zip
    mkdir -p IBMPlexMono && cd IBMPlexMono
    unzip ../IBMPlexMono.zip
    mkdir -p ~/.local/share/fonts
    find . -name \*.ttf -exec cp -v {} ~/.local/share/fonts/ \;
    cd ..
    rm -Rf IBMPlexMono
    rm IBMPlexMono.zip
fi
############################
#     WEZTERM
############################
FILE=~/bin/wezterm
if [ -f "$FILE" ]; then
    echo "$FILE exist. Not updated"
else 
    echo "$FILE does not exist. Installing .."
    
    echo ---- Install wezterm
    curl -LO https://github.com/wez/wezterm/releases/download/nightly/WezTerm-nightly-Ubuntu20.04.AppImage

    chmod +x WezTerm-nightly-Ubuntu20.04.AppImage
    mv ./WezTerm-nightly-Ubuntu20.04.AppImage ~/bin/wezterm

    # Extract icon and create shortcut
    wezterm --appimage-extract
    cp -v squashfs-root/org.wezfurlong.wezterm.png ~/.local/share/icons/
    cp -v squashfs-root/wezterm.desktop ~/.local/share/applications/
    chmod +x ~/.local/share/applications/wezterm.desktop
    rm -Rf  squashfs-root/


    if grep -q WEZTERM_CONFIG_FILE .bashrc ; then 
        echo "WEZTERM_CONFIG_FILE FOUND" 
    else
        curl -LO https://raw.githubusercontent.com/JoMazM/personal_cfg/main/.wezterm.lua
        curl -LO https://raw.githubusercontent.com/JoMazM/personal_cfg/main/chemistry.jpg
        # mv .wezterm.lua ~/bin/.wezterm.lua
        echo Confiugre WEZTERM_CONFIG_FILE=~/bin/.wezterm.lua
        #echo "export WEZTERM_CONFIG_FILE=~/bin/.wezterm.lua" >> .profile
        echo "export WEZTERM_CONFIG_FILE=~/bin/.wezterm.lua" >> ~/.bashrc
    fi
fi


############################
#     NEOVIM
############################
FILE=~/bin/nvim
if [ -f "$FILE" ]; then
    echo "$FILE exist. Not updated"
else 
    echo ---- Install Neovim
    curl  -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
    chmod u+x nvim.appimage
    mv ./nvim.appimage ~/bin/nvim
    
    # Extract icon and create shortcut
    nvim --appimage-extract
    cp -v squashfs-root/nvim.png ~/.local/share/icons/nvim.png
    cp -v squashfs-root/nvim.desktop ~/.local/share/applications/nvim.desktop
    chmod +x ~/.local/share/applications/nvim.desktop
    rm -Rf  squashfs-root/
    
    
    echo -- Setting nvim init.lua configuration
    curl -LO https://raw.githubusercontent.com/JoMazM/personal_cfg/main/init.lua
    mkdir -p ~/.config/nvim
    ln -sf ~/bin/init.lua ~/.config/nvim/init.lua
    
    #Plugin Manager
    echo -- Nvim Plugin manager install
    curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

############################
#     ZIG
############################
if [ -d "~/bin/zig" ]; then
    echo "Zig file exist. Not updated"
else 
    curl -LO https://ziglang.org/builds/zig-linux-x86_64-0.12.0-dev.1849+bb0f7d55e.tar.xz
    tar -xvf zig-linux-x86_64-0.12.0-dev.1849+bb0f7d55e.tar.xz
    mv zig-linux-x86_64-0.12.0-dev.1849+bb0f7d55e zig
    
    if grep -q zig .bashrc ; then 
        echo "zig path found. nothing updated" 
    else
    echo "export PATH=$PATH:~/bin/zig" >> ~/.bashrc
end
