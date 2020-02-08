dotfiles
========

A collection of my personal dotfiles. Here's a little preview of what it can look like:

### Current desktop


![](https://i.imgur.com/VywRKOD.jpg)

![gotop](https://i.imgur.com/qSk2LDQ.jpg)

#### Previous themes

Previous themes can be found on [reddit](https://www.reddit.com/r/unixporn/search?q=author:edbizarro&sort=new&restrict_sr=on&t=all) and [releases](https://github.com/edbizarro/dotfiles/releases) page
### Requirements

* [zsh](http://www.zsh.org)
* [rxvt-unicode](https://wiki.archlinux.org/index.php/rxvt-unicode)
* [tmux](https://github.com/tmux/tmux) + [tpm](https://github.com/tmux-plugins/tpm)
* [prezto](https://github.com/sorin-ionescu/prezto) (for zsh)
* [i3-gaps](https://github.com/Airblader/i3)
* [polybar](https://github.com/jaagr/polybar)
* [tamzen](https://github.com/sunaku/tamzen-font) (font for polybar text)
* [NerdFonts](https://github.com/ryanoasis/nerd-fonts) (font polybar icons)
* [Undefined Medium Fonts](https://github.com/andirueckel/undefined-medium)

### Optional
* [betterlockscreen](https://github.com/pavanjadhaw/betterlockscreen) (fancy lockscreen)
* [mopidy](https://www.mopidy.com/)
* [mons](https://github.com/Ventto/mons)
* [compton](https://github.com/chjj/compton)
* [dunst](https://github.com/dunst-project/dunst)
* [ncmpcpp](http://rybczak.net/ncmpcpp/) + [lyvi](http://ok100.github.io/lyvi/) for lyrics + [bum](https://github.com/dylanaraps/bum) (album artwork)
* [feh](https://feh.finalrewind.org) (change wallpaper)
* [pywal](https://github.com/dylanaraps/pywal) (generate colourschemes based on wallpaper)
* [cava](https://github.com/karlstav/cava)

##### Cool fonts

* [icomoon](https://icomoon.io)
* [Input Font](http://input.fontbureau.com/download/)
* [Pragmata](https://github.com/fabrizioschiavi/pragmatapro)
* Bitmap fonts
   * [tewi-font](https://github.com/lucy/tewi-font)
   * [siji-font](https://github.com/stark/siji)
   * [tamsyn](http://www.fial.com/~scott/tamsyn-font/)
   * [cherry](https://github.com/MarinHoc/cherry-font)
   * [proggyfonts](https://proggyfonts.net/download/) (Monospaced Bitmap Fonts)
   * [scientifica](https://github.com/NerdyPepper/scientifica)
   * [bitmap fonts](https://github.com/Tecate/bitmap-fonts) (A collection of monospaced bitmap fonts)


Installation
------------

Clone this repository:

    git clone https://github.com/edbizarro/dotfiles.git ~/.dotfiles

### Using [GNU Stow](https://www.gnu.org/software/stow/) _(recommended)_
Install GNU Stow _(if not already installed)_

    Mac:      brew install stow
    Ubuntu:   apt-get install stow
    Fedora:   yum install stow
    Arch:     pacman -S stow


Then simply use stow to install the dotfiles you want to use Ex:

    stow xresources

Or to install all my dotfiles config:

    cd ~/.dotfiles && \
      stow i3 && \
      stow mopidy && \
      stow cava && \
      stow ncmpcpp && \
      stow neofetch && \
      stow stow && \
      stow wal && \
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
