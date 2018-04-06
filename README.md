dotfiles
========

A collection of my personal dotfiles. Here's a little preview of what it can look like:

![screenshot](https://raw.githubusercontent.com/edbizarro/dotfiles/master/2newEnG.jpg)

![ncmpcpp](https://github.com/edbizarro/dotfiles/blob/master/mCIAr9Y.jpg)

Installation
------------



#### Requirements

* [zsh](http://www.zsh.org)
* [rxvt-unicode](https://wiki.archlinux.org/index.php/rxvt-unicode)
* [tmux](https://github.com/tmux/tmux)
* [NerdFonts](https://github.com/ryanoasis/nerd-fonts)
* [prezto](https://github.com/sorin-ionescu/prezto) (for zsh)
* [tpm](https://github.com/tmux-plugins/tpm) (for tmux)
* [i3-gaps](https://github.com/Airblader/i3)
* [polybar](https://github.com/jaagr/polybar)
* [mopidy](https://www.mopidy.com/)
* [mons](https://github.com/Ventto/mons)
* [compton](https://github.com/chjj/compton)
* [dunst](https://github.com/dunst-project/dunst)

#### Optional

* [ncmpcpp](http://rybczak.net/ncmpcpp/)
* [feh](https://feh.finalrewind.org) (change wallpaper)
* [pywal](https://github.com/dylanaraps/pywal) (generate colourschemes)
* [cava](https://github.com/karlstav/cava)

##### Cool fonts

* [icomoon](https://icomoon.io)
* [Ohsnap font](https://aur.archlinux.org/packages/ohsnap/)
* [tewi-font](https://github.com/lucy/tewi-font)
* [siji-font](https://github.com/stark/siji)

Clone this repository:

    git clone https://github.com/edbizarro/dotfiles.git ~/.dotfiles

### Using [GNU Stow](https://www.gnu.org/software/stow/) _(recommended)_
Install GNU Stow _(if not already installed)_

    Mac:      brew install stow
    Ubuntu:   apt-get install stow
    Fedora:   yum install stow
    Arch:     pacman -S stow


Then simply use stow to install the dotfiles you want to use:

    cd ~/.dotfiles && \
      stow i3 && \
      stow mopidy && \
      stow cava && \
      stow ncmpcpp && \
      stow git && \
      stow ssh && \
      stow tmux && \
      stow compton && \
      stow dunst && \
      stow xresources && \
      cd ~/.dotfiles/zsh && \
      stow configs -t ~/

We may get some warning messages like the following one:

    cd ~/Dotfiles
    stow git
    WARNING! stowing git would cause conflicts:
      * existing target is neither a link nor a directory: .gitconfig
    All operations aborted.

Or

    WARNING! stowing git would cause conflicts:
      * existing target is not owned by stow: .gitconfig
    All operations aborted.

This means that the file `.gitconfig` (or any other file name that appear in the warning) exists before the symlinking. We need to
manually change its name so GNU Stow can create the symlink. My recommendation is
to rename it:

    mv ~/.gitconfig ~/.gitconfig.old
