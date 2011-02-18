# Class: portconf
#
# This module manages FreeBSD port compiletime defaults via portconf.
# Needed by the portconf::port defined resource.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#   class { "portconf: }
#
# [Remember: No empty lines between comments and class definition]
class portconf {
  $conffile = "/usr/local/etc/ports.conf"
  $basedir = '/tmp'
  package { "portconf": ensure => "present", }
  file {"${basedir}/ports.d":
    ensure  => directory,
    purge   => true,
    recurse => true,
    source  => "puppet:///modules/portconf/ports.d",
    require => Package["portconf"],
  }
  exec { "rebuild-ports":
    command     => "/bin/cat ${basedir}/ports.d/* > ${conffile}",
    refreshonly => true,
    subscribe   => File["${basedir}/ports.d"],
  }
  file { "${conffile}":
    mode      => "644",
    subscribe => Exec["rebuild-ports"],
  }
}
