#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
#sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade --all

# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
# Only have to do this once.
#sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

brew bundle

# Remove outdated versions from the cellar.
brew cleanup
