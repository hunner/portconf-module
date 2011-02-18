# Definition: port
#
# A defined resource for managing the compile-time options for FreeBSD ports.
#
# Parameters:
#   name:    The name of the port to be configured
#   with:    Any port $OPTIONS that should be WITH_
#   without: Any port $OPTIONS that should be WITHOUT_
#   ensure:  Ensure port options are present or absent
#
# Actions:
#
# Requires:
#   class portconf
#
# Sample Usage:
#   portconf::port { "irc/unreal":
#     with    => ["hub","ziplinks","ssl","ipv6","prefixaq"],
#     without => ["nospoof","remote"],
#   }
#
# [Remember: No empty lines between comments and class definition]
define portconf::port ($with = "", $without = "", $ensure = "present") {
  $filename = regsubst($name,"/","_") # port names have /'s in them
  file { "${portconf::basedir}/ports.d/${filename}":
    content => template("portconf/port.erb"),
    notify  => Exec["rebuild-ports"],
    ensure  => $ensure,
  }
}
