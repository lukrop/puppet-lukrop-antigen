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
  $antigen_repo = "${antigen::home}/$user/.antigen"
  exec { 'antigen_exec_update':
    command => "source $antigen_repo/antigen.zsh && antigen update",
    path => '/usr/bin:/usr/sbin:/bin',
    user => $user,
    cwd => "${antigen::home}/$user",
    require => [Antigen::Install[$user]],
  }
}
