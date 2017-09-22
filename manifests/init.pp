# == Class: antigen
#
# A puppet module which installs Antigen, a plugin manager for zsh, inspired by oh-my-zsh and vundle,
# for a user and changes it's shell to zsh.
#
# === Parameters
#
# [*zsh*]
#   path to zsh binary
#
# [*home*]
#   root path of users home directory. Default: '/home'
#
#
# === Examples
#
#  include antigen
#  antigen::install { 'lukrop':
#    library => 'oh-my-zsh',
#    theme => 'mrtazz',
#    bundles => ['git', 'ruby']
#  }
#
# === Authors
#
# Lukas Kropatschek <lukas@kropatschek.net>
#
# === Copyright
#
# Copyright 2015 Lukas Kropatschek.
#
include stdlib
class antigen (
  $zsh = $antigen::params::zsh,
  $home = $antigen::params::home,
  $git_pkg = $antigen::params::git_pkg,
  $zsh_pkg = $antigen::params::zsh_pkg,
) inherits antigen::params {
    # install git and zsh if not present
    if(! defined( Package['git'] )) {
        include ::apt
        package { $antigen::git_pkg:
          ensure => present,
          require => Class['apt::update'],
        }
    }

    if(! defined( Package['zsh'] )) {
        include ::apt
        package { $antigen::zsh_pkg:
          ensure  => present,
          #before => Class['antigen::install'],
          require => Class['apt::update'],
        }
    }
}
