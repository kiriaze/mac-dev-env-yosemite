#!/bin/bash
# Apps
apps=(
  adobe-creative-cloud
  anvil
  appcleaner
  asepsis
  atom
  betterzipql
  brackets
  caffeine
  carbon-copy-cloner
  cloudup
  codekit
  cyberduck
  dropbox
  droplr
  firefox
  flash
  fluid
  flux
  github-desktop
  githubpulse
  google-chrome
  harvest
  iterm2
  keka
  mailbox
  miro
  moom
  mou
  namechanger
  nvalt
  openoffice
  qlcolorcode
  qlimagesize
  qlmarkdown
  qlprettypatch
  qlstephen
  quicklook-csv
  quicklook-json
  screenflick
  sequel-pro
  sketch
  skype
  slack
  smcfancontrol
  sourcetree
  spotify
  sublime-text3
  suspicious-package
  tomighty
  tower
  transmission
  transmit
  unrarx
  vagrant
  virtualbox
  vlc
  webpquicklook
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}
