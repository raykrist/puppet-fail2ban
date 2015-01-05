class fail2ban::install(
  $packages = $fail2ban::packages
) {

  package {
    $packages:
      ensure => latest,
  }

}
