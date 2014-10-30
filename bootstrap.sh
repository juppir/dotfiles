#!/usr/bin/env bash

echo ""
echo "      ___       ___          ___          ___                   ___      "
echo "     /  /\     /__/\        /  /\        /  /\         ___     /  /\     "
echo "    /  /::\    \  \:\      /  /:/_      /  /:/_       /  /\   /  /::\    "
echo "   /  /:/\:\    \  \:\    /  /:/ /\    /  /:/ /\     /  /:/  /  /:/\:\   "
echo "  /  /:/~/:/_____\__\:\  /  /:/_/::\  /  /:/ /::\   /  /:/  /  /:/~/:/   "
echo " /__/:/ /://__/::::::::\/__/:/__\/\:\/__/:/ /:/\:\ /  /::\ /__/:/ /:/___ "
echo " \  \:\/:/ \  \:\~~\~~\/\  \:\ /~~/:/\  \:\/:/~/://__/:/\:\\  \:\/:::::/ "
echo "  \  \::/   \  \:\  ~~~  \  \:\  /:/  \  \::/ /:/ \__\/  \:\\  \::/~~~~  "
echo "   \  \:\    \  \:\       \  \:\/:/    \__\/ /:/       \  \:\\  \:\      "
echo "    \  \:\    \  \:\       \  \::/       /__/:/         \__\/ \  \:\     "
echo "     \__\/     \__\/        \__\/        \__\/                 \__\/     "
echo ""
echo "        ..........................................................       "
echo "        . Dotfiles 0.1.3 (Pongstr) for setting up OSX Workspace  .       "
echo "        .      https://github.com/pongstr/dotfiles.git           .       "
echo "        ..........................................................       "
echo ""

# To run this, you must download & install the latest Xcode and Commandline Tools
# https://developer.apple.com/xcode/
# https://developer.apple.com/downloads/

echo ""
echo "  To run this, you must download & install the latest Xcode and Commandline Tools"
echo "    > https://developer.apple.com/xcode/"
echo "    > https://developer.apple.com/downloads/"
xcode-select --install

# Function to check if a package exists
check () { type -t "${@}" > /dev/null 2>&1; }

# Function to install Homebrew Formulas:
install_formula () {
  echo ""
  echo "Installing Homebrew Packages:"

  echo ""
  echo "  ➜ libyaml"
  brew install libyaml

  echo ""
  echo "  ➜ Install GNU Scientific Library for `rb-gsl` "
  brew install gsl

  echo ""
  echo "  ➜ openssl"
  brew install openssl

  echo ""
  echo "  ➜ git"
  brew install git

  echo ""
  echo "  ➜ python"
  brew install python

  echo ""
  echo "  ➜ node"
  brew install node

  echo ""
  echo "  ➜ mongodb"
  brew install mongo
  mkdir $HOME/.mongodb-data

  echo ""
  echo "  ➜ zsh"
  brew install zsh

  echo ""
  echo "  ➜ vim (overriding system vim)"
  brew install vim --override-system-vi

  # Cleanup
  echo ""
  echo "Cleaning up Homebrew intallation..."
  brew cleanup

  cp -R $HOME/.dotfiles/bin/shell/.bashrc $HOME/.bashrc
  cp -R $HOME/.dotfiles/bin/shell/.bash_alias $HOME/.bash_alias
  cp -R $HOME/.dotfiles/bin/shell/.bash_profile $HOME/.bash_profile

  echo "Installing Caskroom, Caskroom versions and Caskroom Fonts..."
  brew install caskroom/cask/brew-cask
  brew tap caskroom/versions
  brew tap caskroom/fonts

  # Make /Applications the default location of apps
  export HOMEBREW_CASK_OPTS="--appdir=/Applications"

  echo ""
  echo "Installing monospace fonts... "
  brew cask install font-droid-sans-mono
  brew cask install font-ubuntu
  brew cleanup
}


# Install Hushlogin
echo ""
echo "Install hushlogin"
echo "  - Disable the system copyright notice, the date and time of the last login."
echo "    more info at @mathiasbynens/dotfiles http://goo.gl/wZBM80"
echo ""
cp -f "$HOME/.dotfiles/.hushlogin" $HOME/.hushlogin


# Install Homebrew
# ---------------------------------------------------------------------------
echo ""
echo "Checking if Homebrew is installed..."

if check brew; then
  echo "Awesome! Homebrew is installed! Now updating..."
  echo ""
  brew upgrade
  brew update
fi

if ! check brew; then
  echo "Download and install homebrew"
  echo ""
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  # Run Brew doctor before anything else
  brew doctor
fi

# Install Homebrew Formulas
while true; do
  read -p "Would you like to install Homebrew formulas? [y/n] " answer
  echo ""
  case $answer in
    [y]* ) install_formula; break;;
    [n]* ) break;;
    * ) echo "Please answer Y or N.";;
  esac
done


# Install RVM
# ---------------------------------------------------------------------------

echo ""
echo "Installing RVM..."
\curl -L https://get.rvm.io | bash


echo ""
echo ""


# Install Juppir Security Stuff: Paranoia Pill
# ---------------------------------------------------------------------------

echo ""
echo "Disable DMA support. Mitigate attack in tests performed."
sudo kextunload /System/Library/Extensions/IOFireWireFamily.kext/Contents/PlugIns/AppleFWOHCI.kext

echo ""
echo "Clear Filevault keys when enter standby (sleep), which prevents access to data when sleeping."
sudo pmset -a destroyfvkeyonstandby 1 hibernatemode 25

echo ""
echo "Disable Fast-User Switching to disallow multiple user session"
sudo defaults write /Library/Preferences/.GlobalPreferences MultipleSessionEnabled -bool 'NO'


# Setup Wifi Connection: Uncomment to use
# ---------------------------------------------------------------------------

# echo ""
# echo "Turning wifi off: so it will log you out from where you are currently connected."
# networksetup -setairportpower en0 off
# sleep 1

# # re-enable wifi so we can actually use it
# echo ""
# echo "Re-enabling wifi, scanning for available hotspots..."
# networksetup -setairportpower en0 on
# /System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport scan


# echo ""
# echo "Setting Up wifi connection:"
# read -p "Select a Hotspot you'd like to join " HOTSPOT
# read -p "Enter password " PASSWORD
# networksetup -setairportnetwork en0 $HOTSPOT $PASSWORD


# echo ""
# echo "Done!"

# Restart Terminal for RVM to take effect
echo ""
echo "bootstrapping complete! quitting terminal..."
killall Terminal
