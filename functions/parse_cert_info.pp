# @summary Parse the cert name to determine what values to compare against.
#
# Parse the cert name to determine what values to compare against.
#
# @example
#   classification::parse_cert_info($trusted['certname'])
#
# @param trusted_cert_name The value of $trusted['certname'] to be parsed
# @return [Hash] Returns a hash containing certname, cert_hostname, and cert_domain.
function classification::parse_cert_info(String $trusted_cert_name) >> Hash {
  if $trusted_cert_name =~ /\Ai-[a-z0-9]+\Z/ {
    # Temporary work around for unmigrated EC2 nodes (OPS-10034)
    $values = {
      'certname'      => $facts['networking']['fqdn'],
      'cert_hostname' => $facts['networking']['hostname'],
      'cert_domain'   => $facts['networking']['domain'],
    }
  } else {
    $values = {
      'certname'      => $trusted['certname'],
      'cert_hostname' => $trusted['hostname'],
      'cert_domain'   => $trusted['domain'],
    }
  }

  $values
}
