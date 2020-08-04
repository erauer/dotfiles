Dot Files
=========

My collection of my core dotfiles, use at your own risk.

Repo is based on ["The best way to store your dotfiles: A bare Git repository."](https://www.atlassian.com/git/tutorials/dotfiles).

Installation
============

The following lines will set up a bare repository:

```
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config checkout
echo ".cfg" >> .gitignore
git clone --bare <git-repo-url> $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config checkout
config config --local status.showUntrackedFiles no
````

Additional bootstrap scripts may be provided under scripts directory.