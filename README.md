# lukrop-antigen puppet module

#### Table of Contents

1. [Overview](#overview)
2. [Setup](#setup)
    * [What antigen affects](#what-antigen-affects)
3. [Usage](#usage)
4. [Reference](#reference)

## Overview
Installs [antigen](https://github.com/zsh-users/antigen) to easily manage your zsh plugins,
called bundles (e.g. [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)).

## Setup

From the puppet forge:
```shell
$ puppet module install lukrop-antigen
```

Or simply clone this git repository:
```shell
$ git clone https://github.com/lukrop/puppet-lukrop-antigen.git $MODULES_PATH/antigen
```

### What antigen affects
This module..
* clones the antigen git repository to `$HOME/.antigen`
* creates a file `$HOME/.antigen-puppet.zsh` which contains the appropriate antigen commands
to apply a theme, use a library and bundles.
* creates a line in `$HOME/.zshrc` containing `source $HOME/.antigen-puppet.zsh`. If `$HOME/.zshrc`
is not present it will be created.
* changes the given user's shell to zsh

`$HOME` is the home directory of the supplied user.

## Usage
```puppet
# include base class
include antigen

# install for a single user with defaults
antigen::install { 'lukrop': }

# install for a single user with specified theme and bundles
antigen::install { 'lukrop':
  theme => 'mrtazz',
  bundles => ['git', 'ruby'],
}

# install for multiple users
antigen::install { ['root', 'lukrop']: }

# update all bundles for a user
antigen::update { 'lukrop': }

# selfupdate (update antigen itself)
antigen::selfupdate { ['lukrop', 'root']: }

```

## Reference
`antigen` parameters:

* `zsh` path to zsh binary.
* `home` base path for users home directories.
* `git_pkg` optionally supply the name of the git package to be installed. Default: 'git'.
* `zsh_pkg` optionally supply the name of the zsh package to be installed. Default: 'zsh'.

Both, `zsh` and `home` have sensible defaults depending on `$::operatingsystem`. Supported are GNU/Linux, BSD and Darwin.

`antigen::install` parameters:

* `user` user for whom to install antigen. If none is supplied the resource name is used.
* `library` which zsh base library to use. Options are 'oh-my-zsh' or 'prezto'. Default: 'oh-my-zsh'
* `theme` name of the zsh prompt theme. Default: 'clean'
* `bundles` list of bundles to use. Default: ['git']
* `auto_update` if using oh-my-zsh as base library, whether to automatically update oh-my-zsh. This just
exports `DISABLE_AUTO_UPDATE=true`. Default: true.
* `update_prompt` if using oh-my-zsh as base library, whether to show the update prompt. This just exports
`DISABLE_UPDATE_PROMPT=true`. Default: true.
* `force_replace` overwrites existing .zshrc and deletes ~/.antigen if no valid git repo. Default: false.


