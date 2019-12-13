#!/usr/bin/env bash

SETUP_ROOT=$HOME/.setup

NERDFONTS_RELEASE=$(curl -L -s -H 'Accept: application/json' https://github.com/ryanoasis/nerd-fonts/releases/latest)
NERDFONTS_VERSION=$(get_github_version $NERDFONTS_RELEASE)
PATCHED_FONT=$(https://github.com/gabrielelana/awesome-terminal-fonts/raw/patching-strategy/patched/SourceCodePro%2BPowerline%2BAwesome%2BRegular.ttf)

DIRECTORIES=(
    $HOME/designs
    $HOME/development/personal
    $HOME/development/work
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

# TODO: Configure the following
# defaults write com.apple.screencapture location $HOME/Pictures/Screenshots
