# lukrop-antigen puppet module

#### Table of Contents

1. [Overview](#overview)
2. [Setup - The basics of getting started with antigen](#setup)
    * [What antigen affects](#what-antigen-affects)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)

## Overview
Installs [antigen](https://github.com/zsh-users/antigen) to easily manage your zsh plugins,
called bundles (e.g. [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)).

## Setup

### What antigen affects
This module..
* clones the antigen git repository to `$HOME/.antigen`
* creates a file `$HOME/.antigen-puppet.zsh` which contains the appropriate antigen commands
to apply a theme, use a library and bundles.
* creates a line in `$HOME/.zshrc` containing `source $HOME/.antigen-puppet.zsh`. If `$HOME/.zshrc`
is not present it will be created.

`$HOME` is the home directory of the supplied user.

## Usage
```# include base class
include antigen

# install for a single user with defaults
antigen::install { 'lukrop': }

# install for a single user with specified theme and bundles
antigen::install { 'lukrop':
  theme => 'mrtazz',
  bundles => ['git', 'ruby'],
}

#install for multiple users
antigen::install { ['root', 'lukrop']: }
```

## Reference
`antigen` parameters:

* `zsh` path to zsh binary.
* `home` base path for users home directories.

Both, `zsh` and `home` have sensible defaults depending on `$::operatingsystem`. Supported are GNU/Linux, BSD and Darwin.

`antigen::install` parameters:

* `user` user for whom to install antigen. If none is supplied the resource name is used.
* `library` which zsh base library to use. Options are 'oh-my-zsh' or 'prezto'. Default: 'oh-my-zsh'
* `theme` name of the zsh prompt theme. Default: 'clean'
* `bundles` list of bundles to use. Default: ['git']

