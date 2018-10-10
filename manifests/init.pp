# Determine group, function, etc. for classification based on certname
#
# This verifies that untrusted facts match the trusted values found here to
# prevent attacks via fact overrides. Note that incorrect facts can still be
# associated with a node, since facts are sent before compilation.
#
# This uses the same underlying code as the classification fact:
#    lib/ploperations/classification.rb
class classification {
  if $trusted['certname'] =~ /\Ai-[a-z0-9]+\Z/ {
    # Temporary work around for unmigrated EC2 nodes (OPS-10034)
    $certname = $facts['networking']['fqdn']
    $cert_hostname = $facts['networking']['hostname']
    $cert_domain = $facts['networking']['domain']
  } else {
    $certname = $trusted['certname']
    $cert_hostname = $trusted['hostname']
    $cert_domain = $trusted['domain']
  }

  $classification = classification::parse_hostname($cert_hostname)
  $number = $classification['number']
  $parts = $classification['parts']
  [$group, $function, $number_string, $context, $stage, $id] = $parts

  if $classification['version'] == 2 {
    # This uses the version 2 format (group-function-context-stage-#-id);
    # calculate the correct (non-cert) hostname. There are two reasons:
    #
    #   1. When id is present, the node hostname will not include it, but the
    #      cert hostname will.
    #   2. This guarantees that the node hostname is normalized. The certname
    #      is already validated, but this will catch stuff like numbers with
    #      leading 0s.
    $hostname = [$group, $function, $context, $stage, $number]
      .delete_undef_values().delete('').join('-')
  } else {
    $hostname = $cert_hostname
  }

  # The node and the cert may be in different zones, especially if the certname
  # has an id and the hostname does not.
  $domain = pick($trusted['extensions']['pp_network'], $cert_domain)
  $fqdn = "${hostname}.${domain}"

  # Validate untrusted facts
  $root_level_fact_names = [
    'certname',
    'hostname',
    'fqdn',
    'domain',
  ]

  $root_level_calculated_trusted = {
    certname => $trusted['certname'],
    hostname => $hostname,
    fqdn     => $fqdn,
    domain   => $domain,
  }

  $root_level_fact_differences = delete_undef_values($root_level_fact_names.map |$fact_name| {
    $untrusted_value = String($facts[$fact_name])
    $trusted_value = String($root_level_calculated_trusted[$fact_name])

    if $untrusted_value != $trusted_value {
      "    ${fact_name}: '${untrusted_value}' != '${trusted_value}'"
    } else {
      undef
    }
  })

  if $root_level_fact_differences.size() > 0 {
    fail((
      ["Untrusted facts (left) don't match values from certname (right):"]
      + $root_level_fact_differences).join("\n"))
  }

  $classification_fact_names = [
    'hostname',
    'version',
    'group',
    'function',
    'number',
    'number_string',
    'context',
    'stage',
  ]

  $classification_calculated_trusted = $classification + {
    hostname => $hostname,
  }

  $classification_fact_differences = delete_undef_values($classification_fact_names.map |$fact_name| {
    $untrusted_value = $facts['classification'][$fact_name]
    $trusted_value = $classification_calculated_trusted[$fact_name]

    # lint:ignore:80chars lint:ignore:140chars
    if $untrusted_value != $trusted_value {
      "    ${fact_name}: '${untrusted_value}' != '${trusted_value}'\n    ${fact_name} types: ${type($untrusted_value)} != ${type($trusted_value)}"
    } else {
      undef
    }
    # lint:endignore
  })

  if $classification_fact_differences.size() > 0 {
    fail((
      ["Untrusted facts (left) don't match values from certname (right):"]
      + $classification_fact_differences).join("\n"))
  }
}
