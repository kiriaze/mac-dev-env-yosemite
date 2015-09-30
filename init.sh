#!/bin/sh

# Some things taken from here
# https://github.com/mathiasbynens/dotfiles/blob/master/.osx

pretty_print() {
  printf "\n%b\n" "$1"
}

checkFor() {
  type "$1" &> /dev/null ;
}

pretty_print "setting up your dev environment like a boss..."

# Set continue to false by default
CONTINUE=false

pretty_print "\n###############################################"
pretty_print "#        DO NOT RUN THIS SCRIPT BLINDLY       #"
pretty_print "#         YOU'LL PROBABLY REGRET IT...        #"
pretty_print "#                                             #"
pretty_print "#              READ IT THOROUGHLY             #"
pretty_print "#         AND EDIT TO SUIT YOUR NEEDS         #"
pretty_print "###############################################\n\n"

pretty_print "Have you read through the script you're about to run and "
pretty_print "understood that it will make changes to your computer? (y/n)"
read -r response
case $response in
  [yY]) CONTINUE=true
      break;;
  *) break;;
esac

if ! $CONTINUE; then
  # Check if we're continuing and output a message if not
  pretty_print "Please go read the script, it only takes a few minutes"
  exit
fi

# Here we go.. ask for the administrator password upfront and run a
# keep-alive to update existing `sudo` time stamp until script has finished
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


###############################################################################
# General UI/UX
###############################################################################

echo "\nWould you like to set your computer name (as done via System Preferences >> Sharing)?  (y/n)"
read -r response
case $response in
  [yY])
      echo "What would you like it to be?"
      read COMPUTER_NAME
      sudo scutil --set ComputerName $COMPUTER_NAME --set HostName $COMPUTER_NAME --set LocalHostName $COMPUTER_NAME
      sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $COMPUTER_NAME
      break;;
  *) break;;
esac


echo ""
echo "Check for software updates daily, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1



################################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input
###############################################################################

echo ""
echo "Increasing sound quality for Bluetooth headphones/headsets"
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40


###############################################################################
# Finder
###############################################################################

echo ""
echo "Show hidden files in Finder by default? (y/n)"
read -r response
case $response in
  [yY])
    defaults write com.apple.Finder AppleShowAllFiles -bool true
    break;;
  *) break;;
esac

echo ""
echo "Show dotfiles in Finder by default? (y/n)"
read -r response
case $response in
  [yY])
    defaults write com.apple.finder AppleShowAllFiles TRUE
    break;;
  *) break;;
esac

echo ""
echo "Show all filename extensions in Finder by default? (y/n)"
read -r response
case $response in
  [yY])
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true
    break;;
  *) break;;
esac

echo ""
echo "Use column view in all Finder windows by default? (y/n)"
read -r response
case $response in
  [yY])
    defaults write com.apple.finder FXPreferredViewStyle Clmv
    break;;
  *) break;;
esac

echo ""
echo "Avoid creation of .DS_Store files on network volumes? (y/n)"
read -r response
case $response in
  [yY])
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
    break;;
  *) break;;
esac


echo ""
echo "Allowing text selection in Quick Look/Preview in Finder by default"
defaults write com.apple.finder QLEnableTextSelection -bool true


echo ""
echo "Enabling snap-to-grid for icons on the desktop and in other icon views"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist


echo ""
echo "Enabling the Develop menu and the Web Inspector in Safari"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true

echo "\nAdding a context menu item for showing the Web Inspector in web views"
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Use current directory as default search scope in Finder
echo "\nUse current directory as default search scope in Finder"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Show Path bar in Finder
echo "\nShow Path bar in Finder"
defaults write com.apple.finder ShowPathbar -bool true

# Show Status bar in Finder
echo "\nShow Status bar in Finder"
defaults write com.apple.finder ShowStatusBar -bool true

# Show indicator lights for open applications in the Dock
echo "\nShow indicator lights for open applications in the Dock"
defaults write com.apple.dock show-process-indicators -bool true

# Set a blazingly fast keyboard repeat rate
echo "\nSet a blazingly fast keyboard repeat rate"
defaults write NSGlobalDomain KeyRepeat -int 1

# Set a shorter Delay until key repeat
echo "\nSet a shorter Delay until key repeat"
defaults write NSGlobalDomain InitialKeyRepeat -int 12

# Show the ~/Library folder
echo "\nShow the ~/Library folder"
chflags nohidden ~/Library


###############################################################################
# Mail
###############################################################################

echo ""
echo "Setting email addresses to copy as 'foo@example.com' instead of 'Foo Bar <foo@example.com>' in Mail.app"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

###############################################################################
# Terminal
###############################################################################

echo ""
echo "Enabling UTF-8 ONLY in Terminal.app and setting the Pro theme by default"
defaults write com.apple.terminal StringEncodings -array 4
defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"

###############################################################################
# Time Machine
###############################################################################

echo ""
echo "Prevent Time Machine from prompting to use new hard drives as backup volume? (y/n)"
read -r response
case $response in
  [yY])
    defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
    break;;
  *) break;;
esac

###############################################################################
# Transmission.app                                                            #
###############################################################################

echo ""
echo "Do you use Transmission for torrenting? (y/n)"
read -r response
case $response in
  [yY])
    echo ""
    echo "Use `~/Downloads/Incomplete` to store incomplete downloads"
    defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
    mkdir -p ~/Downloads/Incomplete
    defaults write org.m0k.transmission IncompleteDownloadFolder -string "${HOME}/Downloads/Incomplete"

    echo ""
    echo "Don't prompt for confirmation before downloading"
    defaults write org.m0k.transmission DownloadAsk -bool false

    echo ""
    echo "Trash original torrent files"
    defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

    echo ""
    echo "Hide the donate message"
    defaults write org.m0k.transmission WarningDonate -bool false

    echo ""
    echo "Hide the legal disclaimer"
    defaults write org.m0k.transmission WarningLegal -bool false
    break;;
  *) break;;
esac

###############################################################################
# Sublime Text
###############################################################################

echo ""
echo "Do you use Sublime Text 3 as your editor of choice, and is it installed? (y/n)"
read -r response
case $response in
  [yY])
    # Installing from homebrew cask does the following for you!
    # echo ""
    # echo "Linking Sublime Text for command line usage as subl"
    # ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl

    echo ""
    echo "Setting Git to use Sublime Text as default editor"
    git config --global core.editor "subl -n -w"
    break;;
  *) break;;
esac

# xcode dev tools
  pretty_print "Installing xcode dev tools..."
  if [ "$(checkFor pkgutil --pkg-info=com.apple.pkg.CLTools_Executables)" ]; then
    printf 'Command-Line Tools is not installed.  Installing..' ;
    xcode-select --install
    sleep 1
    osascript -e 'tell application "System Events"' -e 'tell process "Install Command Line Developer Tools"' -e 'keystroke return' -e 'click button "Agree" of window "License Agreement"' -e 'end tell' -e 'end tell'
  fi

## xquartz
  pretty_print "Installing xquartz..."
  curl http://xquartz-dl.macosforge.org/SL/XQuartz-2.7.7.dmg -o /tmp/XQuartz.dmg
  open /tmp/XQuartz.dmg
  sudo installer -package /Volumes/XQuartz-2.7.7/XQuartz.pkg -target /
  hdiutil detach /Volumes/XQuartz-2.7.7

# Oh my zsh installation
pretty_print "Installing oh-my-zsh..."
  curl -L http://install.ohmyz.sh | sh

# zsh fix
if [[ -f /etc/zshenv ]]; then
  pretty_print "Fixing OSX zsh environment bug ..."
    sudo mv /etc/{zshenv,zshrc}
fi

# Homebrew installation

if ! command -v brew &>/dev/null; then
  pretty_print "Installing Homebrew, an OSX package manager, follow the instructions..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  if ! grep -qs "recommended by brew doctor" ~/.zshrc; then
    pretty_print "Put Homebrew location earlier in PATH ..."
      printf '\n# recommended by brew doctor\n' >> ~/.zshrc
      printf 'export PATH="/usr/local/bin:$PATH"\n' >> ~/.zshrc
      export PATH="/usr/local/bin:$PATH"
  fi
else
  pretty_print "You already have Homebrew installed...good job!"
fi

# Homebrew OSX libraries

pretty_print "Updating brew formulas"
  	brew update

pretty_print "Installing GNU core utilities..."
	brew install coreutils

pretty_print "Installing GNU find, locate, updatedb and xargs..."
	brew install findutils

pretty_print "Installing the most recent verions of some OSX tools"
	brew tap homebrew/dupes
	brew install homebrew/dupes/grep

printf 'export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"' >> ~/.zshrc
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

# Git installation
pretty_print "Installing git for control version"
  brew install git

# Image magick installation
pretty_print "Installing image magick for image processing"
  brew install imagemagick

# php
pretty_print "Installing php 5.6..."
  brew tap homebrew/versions
  brew tap homebrew/homebrew-php
  brew install php56
  echo 'export PATH="$(brew --prefix homebrew/php/php56)/bin:$PATH"' >> ~/.zshrc && . ~/.zshrc
pretty_print "Setup auto start"
  mkdir -p ~/Library/LaunchAgents
  cp /usr/local/Cellar/php56/5.6.2/homebrew.mxcl.php56.plist ~/Library/LaunchAgents/

# mysql/mariadb
pretty_print "Installing mysql..."
  brew install mysql
  brew unlink mysql
pretty_print "Installing mariadb..."
  brew install mariadb # Install MariaDB
  # mysql setup auto start and start the database
  ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
  launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
  # Run the Database Installer
  unset TMPDIR
  cd /usr/local/Cellar/mariadb/{VERSION}
  mysql_install_db
  mysql.server start # Start MariaDB
  mysql_secure_installation # Secure the Installation

# MongoDB installation
pretty_print "Installing MongoDB"
  brew install mongo

# Reddis installation
pretty_print "Installing Reddis"
  brew install redis

# PostgreSQL installation
pretty_print "Installing PostgreSQL"
  brew install postgresql

# Rbenv installation
pretty_print "Rbenv installation for managing your rubies"
  brew install rbenv

if ! grep -qs "rbenv init" ~/.zshrc; then
  printf 'export PATH="$HOME/.rbenv/bin:$PATH"\n' >> ~/.zshrc
  printf 'eval "$(rbenv init - --no-rehash)"\n' >> ~/.zshrc

  pretty_print "Enable shims and autocompletion ..."
    eval "$(rbenv init -)"
fi


export PATH="$HOME/.rbenv/bin:$PATH"

pretty_print "Installing rbenv-gem-rehash, we don't want to rehash everytime we add a gem..."
  brew install rbenv-gem-rehash

pretty_print "Installing ruby-build to install Rubies ..."
  brew install ruby-build

# OpenSSL linking
pretty_print "Installing and linking OpenSSL..."
brew install openssl
brew link openssl --force

# Install ruby latest version
ruby_version="$(curl -sSL https://raw.githubusercontent.com/IcaliaLabs/kaishi/master/latest_ruby)"

pretty_print "Installing Ruby $ruby_version"
  if [ "$ruby_version" = "2.1.1" ]; then
    curl -fsSL https://gist.github.com/mislav/a18b9d7f0dc5b9efc162.txt | rbenv install --patch 2.1.1
  else
    rbenv install "$ruby_version"
  fi

  pretty_print "Set ruby version $ruby_version as the default"

  rbenv global "$ruby_version"
  rbenv rehash

pretty_print "Updating gems..."
  gem update --system

pretty_print "Setup gemrc for default options"
  if [ ! -f ~/.gemrc ]; then
    printf 'gem: --no-document' >> ~/.gemrc
  fi

# Bundler installation
pretty_print "Installing bundler..."
  gem install bundler
#
pretty_print "Optimizing Bundler..."
  number_of_cores=$(sysctl -n hw.ncpu)
  bundle config --global jobs $((number_of_cores - 1))

pretty_print "Installing Foreman..."
  gem install foreman

pretty_print "Installing Rails...finally!"
  gem install rails

pretty_print "Installing mailcatcher gem...!"
  gem install mailcatcher

pretty_print "Installing the heroku toolbelt..."
  brew install heroku-toolbelt

pretty_print "Installing custom Rails app generator from Icalia"
  curl -L https://raw2.github.com/IcaliaLabs/railsAppCustomGenerator/master/install.sh | sh

pretty_print "Installing pow to serve local rails apps like a superhero..."
  curl get.pow.cx | sh

pretty_print "Installing NodeJs..."
  brew install node

pretty_print "Installing Grunt..."
  npm install -g grunt-cli

pretty_print "Installing Composer..."
  brew update
  brew install composer

pretty_print "Installing Bower..."
  npm install -g bower

pretty_print "Installing Gulp..."
  npm install --global gulp

# Install brew cask
pretty_print "Installing cask to install apps"
	brew install caskroom/cask/brew-cask
  brew tap caskroom/versions

pretty_print "Installing launchrocket to manage your homebrew formulas like a champ!"
	brew cask install launchrocket

pretty_print "Installing apps..."
  sh apps.sh

pretty_print "Installing fonts..."
  sh fonts.sh

# install adove creative cloud app from cask install
pretty_print "Adobe Creative Cloud - cask requires to run the installer again"
  open /opt/homebrew-cask/Caskroom/adobe-creative-cloud/latest/Creative\ Cloud\ Installer.app

# when done with cask
brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup

# iterm - copy files into ~ dir
pretty_print "Setup iterm..."
  cp {.bash_profile,.bash_prompt,.aliases} ~

# Install Mackup
pretty_print "Installing Mackup..."
  brew install mackup

# Launch it and back up your files
pretty_print "Running Mackup Backup...required dropbox to be setup first. Run again with $mackup backup"
  mackup backup

###############################################################################
# Kill affected applications
###############################################################################

echo ""
pretty_print "Shits Done Bro! You still need to manually install pacakge installer within sublime, setup your hosts, httpd.conf and vhosts files, download chrome extensions, setup your hotspots/mouse settings, and setup your git shit - look at readme for more info."
echo ""
echo ""
pretty_print "################################################################################"
echo ""
echo ""
pretty_print "Note that some of these changes require a logout/restart to take effect."
pretty_print "Killing some open applications in order to take effect."
echo ""

find ~/Library/Application\ Support/Dock -name "*.db" -maxdepth 1 -delete
for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
  "Dock" "Finder" "Mail" "Messages" "Safari" "SystemUIServer" \
  "Terminal" "Transmission"; do
  killall "${app}" > /dev/null 2>&1
done
