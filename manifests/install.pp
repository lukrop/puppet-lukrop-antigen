# == Class: antigen::install
#
# Installs Antigen, a plugin manager for zsh, inspired by oh-my-zsh and vundle,
# for a user and changes it's shell to zsh.
#
# === Parameters
# # [*user*]
#  user for whom to install antigen. If none is supplied the resource name is used.
#
# [*library*]
#   which zsh library to use. Can by 'oh-my-zsh' or 'prezto'. Default: 'oh-my-zsh'
#
# [*theme*]
#   zsh prompt theme to use. Default: 'clean'
#
# [*bundles*]
#   list of bundles to use. Default: ['git']
#
# === Examples
#
#  include antigen
#  antigen::install { 'lukrop': theme => 'mrtazz' }
#
# === Authors
#
# Lukas Kropatschek <lukas@kropatschek.net>
#
# === Copyright
#
# Copyright 2015 Lukas Kropatschek.
#
define antigen::install (
  String $user = $title,
  String $library = 'oh-my-zsh',
  String $theme = 'clean',
  Array $bundles = ['git'],
) {
  # make appropriate changes for root
  if $user == 'root' { $home = '/root' } else { $home = "${antigen::home}/$user" }

  $antigen_repo = "$home/.antigen"
  # clone antigen to users home directory
  vcsrepo { $antigen_repo :
    ensure => present,
    provider => git,
    source => 'https://github.com/zsh-users/antigen.git',
    user => $user,
  }

  file { "$home/.antigen-puppet.zsh":
    content => template('antigen/antigen-puppet.zsh.erb'),
    owner => $user,
  }

  # source our antigen-puppet.zsh in users .zshrc
  file { "$home/.zshrc": ensure => present }
  file_line { 'source antigen-puppet.zsh' :
    path => "$home/.zshrc",
    ensure => present,
    line => "source $home/.antigen-puppet.zsh",
    require => [Vcsrepo[$antigen_repo], File["$home/.antigen-puppet.zsh"], File["$home/.zshrc"]],
  }

  # set zsh as default shell for the user
  if defined(User[$user]) {
      User <| title == $user |> {
        shell => $antigen::zsh
      }
  } else {
    exec { 'antigen_exec_chsh':
      command => "chsh -s $antigen::zsh $user",
    }
  }
}

