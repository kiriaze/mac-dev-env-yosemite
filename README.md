MDE (mac-dev-env)
===========

### Update (11.3.14)

Self executing script v.1. Please read through script.

	$ sh ./init.sh

---

### General Notes
Assumes this is on a fresh install of Yosemite. If you already have an environment setup, dont run the init.sh script, rather comb through this and cherry pick. Hopefully you're not using mamp or the like.

All references to `subl` is for opening files within the Sublime Text editor, if you haven't heard of it, no worries, this setup will install it for you and set up an alias to use it with.

Make sure your bash scripts have had `chmod +x` ran on them; e.g. `chmod +x script.sh`, making the file executable by everyone.

Mac Dev Env Setup consists of:

	homebrew
	php 5.6
	update mac unix tools
	correct paths
	git
	ruby
	mysql/mariadb
	bash/zsh
	node
	nginx
	composer
	bower
	bundler
	grunt
	gulp
	cask - pretty much all your apps
	mackup - keep your app settings in sync. wHAT?! word.
	SublimeText3 / Chrome extensions
	iTerm settings

# Run this exactly like this.

1. system pref
	* change name of computer
	* mouse/trackpad settings
	* hotspots

2. software updates
	* make sure youve updated everything.

3. xcode dev tools:
	* `$ xcode-select --install`
		* get xcode
		* install dev tools

## xquartz
	$ curl http://xquartz-dl.macosforge.org/SL/XQuartz-2.7.7.dmg -o /tmp/XQuartz.dmg
	$ open /tmp/XQuartz.dmg

## homebrew
	$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	$ echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile
	$ brew doctor
	$ brew update
	$ brew upgrade
	$ brew tap homebrew/dupes
	$ brew tap homebrew/versions
	$ brew tap homebrew/homebrew-php # theres also: brew tap homebrew/php
	$ brew install php56
	$ brew install imagemagick


## Update the unix tools you already have on your mac.
1. Install GNU core utilities (those that come with OS X are outdated)
	* `$ brew install coreutils`

2. Install GNU "find", "locate", "updatedb", and "xargs", g-prefixed
	* `$ brew install findutils`

### Install Bash 4
`$ brew install bash`

### Install more recent versions of some OS X tools
`$ brew install homebrew/dupes/grep`

#### You'll need to update PATH in your ~/.bash_profile to use these over their Mac counterparts:

	$ echo export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH" >> ~/.bash_profile
	$ brew cleanup

### ZSH
#### [Why should you be using ZSH instead of bash](https://github.com/robbyrussell/oh-my-zsh)
	$ brew install zsh
	$ sudo mv /etc/zshenv /etc/zprofile
	$ cat /etc/shells | grep zsh || which zsh | sudo tee -a /etc/shells
	$ chsh -s $(which zsh)


## Setup PHP CLI binary

### If you use Bash
`$ echo 'export PATH="$(brew --prefix homebrew/php/php56)/bin:$PATH"' >> ~/.bash_profile && . ~/.bash_profile`

### If you use ZSH
`$ echo 'export PATH="$(brew --prefix homebrew/php/php56)/bin:$PATH"' >> ~/.zshrc && . ~/.zshrc`


## Setup auto start
	$ mkdir -p ~/Library/LaunchAgents
	# note below, path version might be different
	$ cp /usr/local/Cellar/php56/5.6.2/homebrew.mxcl.php56.plist ~/Library/LaunchAgents/


### mysql
`$ brew install mysql`


### MariaDB
	$ brew unlink mysql
	$ brew info mariadb # Verify MariaDB Version in Homebrew Repo
	$ brew install mariadb # Install MariaDB

	# mysql setup auto start and start the database
	$ ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
	$ launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist

	# Run the Database Installer
	$ unset TMPDIR
	$ cd /usr/local/Cellar/mariadb/{VERSION}
	$ mysql_install_db

	$ mysql.server start # Start MariaDB
	$ mysql_secure_installation # Secure the Installation
	$ mysql -u root -p # Connect to MariaDB



### Git
	$ brew install git

	# Write settings to ~/.gitconfig
	$ git config --global user.name '{YOUR NAME}'
	$ git config --global user.email {YOUR EMAIL}

	# a global git ignore file:
	$ git config --global core.excludesfile '~/.gitignore'
	$ echo '.DS_Store' >> ~/.gitignore

	# use keychain for storing passwords
	$ git config --global credential.helper osxkeychain

	# you might not see colors without this
	$ git config --global color.ui true

	# more useful settings: https://github.com/glebm/dotfiles/blob/master/.gitconfig

	# ssh keys - probably can skip this since github app auto adds it for you which is nice
	$ ls -al ~/.ssh # Lists the files in your .ssh directory, if they exist
	$ ssh-keygen -t rsa -C "your_email@example.com" # Creates a new ssh key, using the provided email as a label
	$ eval "$(ssh-agent -s)" # start the ssh-agent in the background
	$ ssh-add ~/.ssh/id_rsa
	$ pbcopy < ~/.ssh/id_rsa.pub # Copies the contents of the id_rsa.pub file to your clipboard to paste in github or w/e


### RVM
	$ curl -L https://get.rvm.io | bash -s stable --ruby
	$ brew update && brew upgrade
	$ rvm reinstall 2.1.3 --disable-binary


### Node
	$ brew update
	$ brew install node


### composer
	$ brew update
	$ brew install composer
### bower
	$ npm install -g bower
### bundler
	$ gem install bundler
	# now you can use guard within projects
### Grunt
	$ npm install -g grunt-cli
### gulp
	$ npm install --global gulp


### Cask
	$ brew install caskroom/cask/brew-cask
		// If you want to install beta versions of things like Chrome Canary or Sublime Text 3,
	$ brew tap caskroom/versions
	$ brew cask install google-chrome # per app
	$ brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup # when done

	// fonts
	$ brew tap caskroom/fonts

	// apps
	# bash script to install apps -> apps.sh
	$ chmod u+x apps.sh # make it executable
	$ apps.sh # run it

### iterm
	$ cd ~
	$ curl -O https://raw.githubusercontent.com/nicolashery/mac-dev-setup/master/.bash_profile
	$ curl -O https://raw.githubusercontent.com/nicolashery/mac-dev-setup/master/.bash_prompt
	$ curl -O https://raw.githubusercontent.com/nicolashery/mac-dev-setup/master/.aliases

### chrome extenstions
1. edit this cookie
2. page speed insights
3. yslow
4. sway keys
5. adblocker
6. eye dropper
7. panda
8. onetab
9. hola
10. Chrome launcher app

### Sublime Text 3
#### install package installer
1. ctrl+` # opens console in sublime, paste below into console.
2. `import urllib.request,os,hashlib; h = 'eb2297e1a458f27d836c04bb0cbaf282' + 'd0e7a3098092775ccb37ca9d6b2e4b7d'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)`

#### ST3 Packages
1. theme-default
2. brogrammer
3. sidebar-enhnacemnets
4. sidebar-folders
5. tabs-extra
6. alignment
7. codekit (.kit)
8. emmet
9. angularjs
10. sass
11. scss
12. docblocker
13. editorconfig
14. html-css-js-prettify
15. js hint
16. move tab
17. origami
18. markdown
19. movetab
20. unsplash
21. wordpress
22. sublimecodeintel
23. jekyll
24. trimmer
25. syncedSidebar

### Install Mackup
`$ brew install mackup`

### Launch it and back up your files
`$ mackup backup`

### Local OSX Yosemite Apache Setup
In Yosemite, Apache 2.4.9 is installed. We just have to use the command line to start and stop it.

One change compared to 2.2.x worth noting is that we now need the Require all granted directive in our virtual host definitions in place of Allow from all.

```
cd /etc/apache2
subl /etc/apache2/httpd.conf
```
Within the httpd.conf:

1. To enable PHP and rewriting in Apache, remove the leading # from these lines:
    ```
    #LoadModule rewrite_module libexec/apache2/mod_rewrite.so
    #LoadModule php5_module libexec/apache2/libphp5.so
    # Include /private/etc/apache2/extra/httpd-vhosts.conf
    ```

2. Update yur file's Apache User/Group from `_www` to your `$(whoami)` and `staff` at around line 181-182. 

3. At around line 236, you'll find the DocumentRoot and `<Directory "/Library/WebServer/Documents">`. Update both to: `/Users/$(whoami)/Localhost` or whichever destination you prefer.

4. Also, within `<Directory>`, update `AllowOverride None` to `AllowOverride All` so that .htaccess files will work as well as `Options FollowSymLinks Multiviews` to `Options FollowSymLinks Multiviews Indexes` so that we can view directory listings.

5. Create a $(whoami).conf within the etc/apache2/users/ directory.
    ```
    <Directory "/Users/$(whoami)/Localhost/">
    	AllowOverride All
    	Options Indexes MultiViews FollowSymLinks
    	Require all granted
    </Directory>
    ```

4. Give yourself permissions to the /Users/$(whoami)/Localhost/ folder using these cli commands:
	```
	sudo chgrp staff /Users/$(whoami)/Localhost
	sudo chmod g+rws /Users/$(whoami)/Localhost
	sudo chmod g+rw /Users/$(whoami)/Localhost/*
	// or otherwise specifically...but the above should handle anything added from there on out
	sudo chmod -R g+w {path}
	```

5. Remove the content ( if you want ) from /etc/apache2/extra/httpd-vhosts.conf and add the code below before everything else
	```
	NameVirtualHost *:80
	```
Followed by an example virtual host that points to the root of your web project directory e.g. Localhost
	```
	<VirtualHost *:80>
	    DocumentRoot "/Users/kiriaze/Localhost"
	</VirtualHost>
	```

6. Restart Apache: `sudo apachectl restart`

7. Create a new file called info.php with <?php phpinfo(); ?> inside your new document root; e.g. /Users/$(whoami)/Localhost/.

8. Use your browser to navigate to `localhost/info.php` and check your PHP version, as well as anything else you might need to reference in the future.


## Notes

1. The init.sh script also installs a few other things such as: adobe-creative-cloud, MongoDB, Reddis, PostgreSQL - and you can setup your git global creds from the script as well.

2. Use [Ghosts](https://github.com/kiriaze/ghost) when creating new projects in conjuncture with this setup, and have a beer cuz you just became a fly ass mother fucker. A one liner to reference below: 
	```
	bash <(curl -s https://raw.githubusercontent.com/kiriaze/ghosts/master/ghosts.sh)
	```

## Todos

Include usage of MongoDB, Reddis, PostgreSQL.
