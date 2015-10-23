# == Function: antigen::update
#
# Updates antigen itself. This basically is a git pull.
#
# === Parameters
#
# [*user*]
#   user for whom to update antigen itself.
#
# === Examples
#
#  antigen::selfupdate { 'lukrop': }
#
# === Authors
#
# Lukas Kropatschek <lukas@kropatschek.net>
#
# === Copyright
#
# Copyright 2015 Lukas Kropatschek.
#

define antigen::selfupdate ($user = $title) {
  $antigen_repo = "${antigen::home}/$user/.antigen"
  exec { 'antigen_exec_selfupdate':
    command => "source $antigen_repo/antigen.zsh && antigen selfupdate",
    user => $user,
    cwd => "${antigen::home}/$user",
    require => [Antigen::Install[$user]],
  }
}
