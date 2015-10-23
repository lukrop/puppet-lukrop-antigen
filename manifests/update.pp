# == Function: antigen::update
#
# Updates all antigen bundles.
#
# === Parameters
#
# [*user*]
#   user for whom to update all bundles. If none is supplied the resource name is used.
#
#
# === Examples
#
#  antigen::update { 'lukrop': }
#
# === Authors
#
# Lukas Kropatschek <lukas@kropatschek.net>
#
# === Copyright
#
# Copyright 2015 Lukas Kropatschek.
#

define antigen::update ($user = $title) {
  if $user == 'root' {
    $antigen_repo = '/root/.antigen'
  } else {
    $antigen_repo = "${antigen::home}/$user/.antigen"
  }
  exec { 'antigen_exec_update':
    command => "$antigen::zsh -c 'source $antigen_repo/antigen.zsh && antigen update'",
    user => $user,
    require => [Antigen::Install[$user]],
  }
}
