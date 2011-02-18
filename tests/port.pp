class { "portconf": }
portconf::port { "irc/unreal":
  with    => ["hub","ziplinks","ssl","ipv6","prefixaq"],
  without => ["nospoof","remote"],
}
