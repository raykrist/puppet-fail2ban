puppet-fail2ban
===============

fail2ban puppet module

note on puppetlabs-firwall module
---------------------------------

```puppet
# Purge INPUT chain, but ignore fail2ban rules if used
$use_fail2ban = true
firewallchain { 'INPUT:filter:IPv4':
  purge  => true,
  ignore => $use_fail2ban ? {
    true => ['-p tcp -m tcp --dport 22 -j f2b-SSH'],
    default => undef
  },
}
```
