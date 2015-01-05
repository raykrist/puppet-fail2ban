class fail2ban::config(
  $fail2ban_loglevel  = $fail2ban::fail2ban_loglevel,
  $logtarget          = $fail2ban::logtarget,
  $socekt             = $fail2ban::socket,
  $jailconf           = $fail2ban::jailconf,
  $ignoreip           = $fail2ban::ignoreip,
  $backend            = $fail2ban::backend
) {

  File {
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  # Replace the package jail.conf with the default jail.conf to avoid
  # (Debian) package managers to fuck you over!
  file { '/etc/fail2ban/jail.conf':
    ensure => present,
    source => "puppet:///modules/${module_name}/jail.conf"
  }
  file { '/etc/fail2ban/fail2ban.local':
    ensure  => present,
    content => template("${module_name}/fail2ban.local.erb"),
    notify => Class['fail2ban::service']
  }

  concat { $jailconf:
    owner => root,
    group => root,
    mode  => '0644',
    replace => true,
  }
  concat::fragment { "${name}_jail":
    target  => $jailconf,
    content => template("${module_name}/jail.default.local.erb"),
    order   => 1,
  }

}
