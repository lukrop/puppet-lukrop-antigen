# == Class: antigen::params
#
# Defines some default parameters depending on the operating system.
#
# === Parameters
#
# [*zsh*]
#   path to zsh binary
#
# [*home*]
#   root path of users home directory. Default: '/home'
#
# === Authors
#
# Lukas Kropatschek <lukas@kropatschek.net>
#
# === Copyright
#
# Copyright 2015 Lukas Kropatschek.
#
class antigen::params {
  case $::operatingsystem {
    /(?i:FreeBSD)/: {
      $zsh = '/usr/local/bin/zsh'
      $home = '/home'
      $zsh_pkg = 'zsh'
      $git_pkg = 'git'
    }
    /(?i:Darwin)/: {
      $zsh = '/bin/zsh'
      $home = '/Users'
      $zsh_pkg = 'zsh'
      $git_pkg = 'git'
    }
    /(?i:Debian)/: {
      case $::lsbdistcodename {
        'stretch': {
          $zsh = '/bin/zsh'
        }
        default: {
          $zsh = '/usr/bin/zsh'
        }
      }
      $home = '/home'
      $zsh_pkg = 'zsh'
      $git_pkg = 'git'
    }
    default: {
      $zsh = '/usr/bin/zsh'
      $home = '/home'
      $zsh_pkg = 'zsh'
      $git_pkg = 'git'
    }
  }
}
