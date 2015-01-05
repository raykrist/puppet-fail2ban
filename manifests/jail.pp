# == Class: fail2ban::jail
#
# Add a new jail to fail2ban. Fail2ban module must be declared before
# this is can be used.
#
# === Parameters
#
# [*filter*]
#   One of the Fail2ban filter from /etc/fail2ban/filter.d/
#
# [*action*]
#   Array with Fail2ban actions from /etc/fail2ban/action.d/  
#
# [*logpath*]
#   Path to log file for this jail
#
# === Example
#
# fail2ban::jail { 'ssh-iptables':
#    filter => 'sshd',
#    logpath => '/var/log/secure',
#    maxretry => 3,
#    bantime => 600,
#    findtime => 600,
#    action => [
#      "iptables[name=SSH, port=ssh, protocol=tcp]",
#      "mail-whois[name=SSH, dest=yourmail@mail.com]" ],
#  }
#
# === Authors
#
# Raymond Kristiansen <raymond@uib.no>
#
# === Copyright
#
# Copyright 2013 UiB
#
define fail2ban::jail(
  $filter,
  $action,
  $logpath,
  $jailconf           = $fail2ban::jailconf,
  $order              = 10,
  $enabled            = 'true',
  $maxretry           = 3,
  $bantime           = 600,
  $findtime           = 600
) {
  
  if !is_array($action) {
    err('action must be array')
  }
  
  concat::fragment { "${name}_jail":
    target  => $jailconf,
    content => template("${module_name}/jail.local.erb"),
    order   => $order,
    require => Class['fail2ban']
  }
  
}
