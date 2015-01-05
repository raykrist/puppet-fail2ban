class fail2ban(
  $fail2ban_loglevel  = 3,
  $logtarget          = '/var/log/fail2ban.log',
  $socket             = '/var/run/fail2ban/fail2ban.sock',
  $packages           = 'fail2ban',
  $jailconf           = '/etc/fail2ban/jail.local',
  $ignoreip           = '127.0.0.1/8',
  $backend            = 'auto'
) {
  
  class { 'fail2ban::install': } ->
  class { 'fail2ban::config': } ->
  class { 'fail2ban::service': }

}
