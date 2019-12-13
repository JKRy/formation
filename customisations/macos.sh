#!/bin/bash

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    echo "I'm sorry but there's not much to uninstall here"
    exit
fi

###############################################################################
# Dock                                                                        #
###############################################################################
echo "Configuring Dock"

defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock "show-recents" -bool false
defaults write com.apple.dock orientation -string "left"


###############################################################################
# Trackpad & keyboard                                                         #
###############################################################################
echo "Configuring Trackpad & Keyboard"

# Use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
# Follow the keyboard focus while zoomed in
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

###############################################################################
# Finder                                                                      #
###############################################################################
echo "Configuring Finder"


# Use list view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

###############################################################################
# Menu Bar                                                                    #
###############################################################################
echo "Configuring Menu Bar"


# Show Battery Percentage on the meny bar
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

###############################################################################

echo "Killing all affected apps to apply the changes"

# Kill all affected apps
for app in "cfprefsd" "Dock" "Finder" "Mail" "Safari" "SystemUIServer"; do
    killall "${app}" > /dev/null 2>&1
done