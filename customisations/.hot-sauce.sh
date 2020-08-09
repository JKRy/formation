#!/usr/bin/env bash
dotfiles_folder="/Users/$(whoami)/code/personal/dotfiles"

NERDFONTS_RELEASE=$(curl -L -s -H 'Accept: application/json' https://github.com/ryanoasis/nerd-fonts/releases/latest)
NERDFONTS_VERSION=$(get_github_version $NERDFONTS_RELEASE)
PATCHED_FONT=$(https://github.com/gabrielelana/awesome-terminal-fonts/raw/patching-strategy/patched/SourceCodePro%2BPowerline%2BAwesome%2BRegular.ttf)

DIRECTORIES=(
    $HOME/designs
    $HOME/code/work
    $HOME/tools
    $HOME/Desktop/screenshots
)

NERDFONTS=(
    SpaceMono
    Hack
    AnonymousPro
    Inconsolata
)

step "Making directories…"
for dir in ${DIRECTORIES[@]}; do
    mkd $dir
done

step "Installing patched font"
if [ ! -d ~/Library/Fonts/SourceCodePro+Powerline+Awesome+Regular ]; then
    printf "${indent}  [↓] $font "
    wget -P ~/Library/Fonts $PATCHED_FONT --quiet
else
    print_muted "${indent}✓ $font already installed. Skipped."
fi

step "Installing fonts…"
for font in ${NERDFONTS[@]}; do
    if [ ! -d ~/Library/Fonts/$font ]; then
        printf "${indent}  [↓] $font "
        wget -P ~/Library/Fonts https://github.com/ryanoasis/nerd-fonts/releases/download/$NERDFONTS_VERSION/$font.zip --quiet;unzip -q ~/Library/Fonts/$font -d ~/Library/Fonts/$font
        print_in_green "${bold}✓ done!${normal}\n"
    else
        print_muted "${indent}✓ $font already installed. Skipped."
    fi
done

step "Set up iTerm2 Profiles"
local iterm_folder="${HOME}/Library/Application Support/iTerm2/DynamicProfiles"

sudo mkdir -p $iterm_folder

if [[ -d $iterm_folder ]]; then
    cp $dotfiles_folder/customisations/iterm/*.json ~/Library/Application\ Support/iTerm2/DynamicProfiles/
    print_in_green "Successfully copied profiles - enable via iTerm preferences"
else
    print_muted "Path does not exist: ${iterm_folder}. Skipped"
fi

step "Copy zshrc"
local zshrc=$dotfiles_folder/customisations/.zshrc
if [ -e $zshrc ]; then
    cp $zshrc $HOME
    print_success ".zshrc file successfully copied"
else print_success_muted "No .zshrc file found. Skipping"
fi

step "Copy vscode settings"
local code_settings=$dotfiles_folder/customisations/code/settings.json
if [ -e $code_settings ]; then
    cp $code_settings ~/Library/Application\ Support/Code/User/
     print_success "vscode settings json successfully copied"
else print_success_muted "No settings file found. Skipping"
fi

step "Copy vscode keybindings"
local code_keybindings=$dotfiles_folder/customisations/code/keybindings.json
if [ -e $code_keybindings ]; then
    cp $code_keybindings ~/Library/Application\ Support/Code/User/
     print_success "vscode keybindings file successfully copied"
else print_success_muted "No keybindings file found. Skipping"
fi

step "Copy gitconfig"
local gitconfig=$dotfiles_folder/customisations/.gitconfig
if [ -e $gitconfig ]; then
    cp $gitconfig $HOME
     print_success ".gitconfig file successfully copied"
else print_success_muted "No .gitconfig file found. Skipping"
fi

step "MacOS Configuration"
if [ -e $dotfiles_folder/customisations/macos.sh ]; then
    bash $dotfiles_folder/customisations/macos.sh
     print_success "macOS configuration successful"
else print_success_muted "No macOS configuration file found. Skipping"
fi