ZSH
===

Installation
------------

(Clone Prezto)
```bash
$ git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
```

(Clone Dotfiles)
```bash
git clone --recursive https://gitlab.com/geekpobre/dotfiles.git "${ZDOTDIR:-$HOME}/.dotfiles"
```

(Create Symlinks)
```bash
setopt EXTENDED_GLOB
for f in "${ZDOTDIR:-$HOME}"/.dotfiles/zsh/configs/*.zsh; do
  ln -s "$f" "${ZDOTDIR:-$HOME}/.${f:t}"
done
```

Requirements
------------

[prezto](https://github.com/sorin-ionescu/prezto) - (Hard Requirement)

[nvm](https://github.com/creationix/nvm) - (Soft Requirement)

[chruby](https://github.com/postmodern/chruby) - (Soft Requirement)

[fasd](https://github.com/clvv/fasd) - (Soft Requirement)

[virtualenv](https://github.com/pypa/virtualenv) - (Soft Requirement)

[virtualenvwrapper](https://bitbucket.org/virtualenvwrapper/virtualenvwrapper) - (Soft Requirement)


Structure
---------

**Configs [Loaded: 1]**
prezto framework files.

_zshenv_ - This file is sourced by all instances of Zsh, and thus, it should be kept as small as possible and should only define environment variables.

_zprofile_ - This file is similar to zlogin, but it is sourced before zshrc. It was added for KornShell fans. See the description of zlogin below for what it may contain. zprofile and zlogin are not meant to be used concurrently but can be done so.

_zshrc_ - This file is sourced by interactive shells. It should define aliases, functions, shell options, and key bindings.

_zpreztorc_ - This file configures Prezto.

_zlogin_ - This file is sourced by login shells after zshrc, and thus, it should contain commands that need to execute at login. It is usually used for messages such as fortune, msgs, or for the creation of files. This is not the file to define aliases, functions, shell options, and key bindings. It should not change the shell environment.

_zlogout_ - This file is sourced by login shells during logout. It should be used for displaying messages and the deletion of files.


**Exports [Loaded: 2]**
exports for the shell.

**Aliases [Loaded: 3]**
aliases for the shell.

**Plugins [Loaded: 4]**
extra calls for other stuff like nvm.
    
