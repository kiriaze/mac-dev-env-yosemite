#!/bin/bash
# Apps
apps=(
  dropbox
  google-chrome
  firefox
  screenflick
  slack
  transmit
  appcleaner
  spotify
  vagrant
  flash
  iterm2
  qlcolorcode
  qlstephen
  qlmarkdown
  quicklook-json
  qlprettypatch
  quicklook-csv
  betterzipql
  webpquicklook
  suspicious-package
  asepsis
  shiori
  sublime-text3
  virtualbox
  atom
  flux
  mailbox
  sketch
  tower
  vlc
  cloudup
  nvalt
  skype
  transmission
  anvil
  brackets
  caffeine
  carbon-copy-cloner
  cyberduck
  droplr
  fluid
  harvest
  keka
  miro
  mou
  moom
  namechanger
  openoffice
  parallels-desktop
  smcfancontrol
  sourcetree
  unrarx
  sequel-pro
  github
  codekit
  tomighty
  rescuetime
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}
