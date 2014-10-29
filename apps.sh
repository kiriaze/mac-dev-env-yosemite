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
  qlprettypatch
  shiori
  sublime-text3
  virtualbox
  atom
  flux
  mailbox
  qlstephen
  sketch
  tower
  vlc
  cloudup
  nvalt
  quicklook-json
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
  nameChanger
  openoffice
  parallels
  smcfancontrol
  sourcetree
  twin
  unrarx
  sequel-pro
  github
  codekit

)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}