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
    }
    /(?i:Darwin)/: {
      $zsh = '/bin/zsh'
      $home = '/Users'
    }
    default: {
      $zsh = '/usr/bin/zsh'
      $home = '/home'
    }
  }
}
