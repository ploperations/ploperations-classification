# @summary Determine group, function, etc. for classification based on certname.
#
# Determine group, function, etc. for classification based on certname.
# This verifies that untrusted facts match the trusted values found here to
# prevent attacks via fact overrides. Note that incorrect facts can still be
# associated with a node since facts are sent before compilation.
#
# This uses the same underlying code as the classification fact:
#    `lib/ploperations/classification.rb`
#
# @example Automatically include on every node
#   # in site.pp:
#   include classification
class classification {
  $parsed_trusted_cert_name = classification::parse_cert_info($trusted['certname'])
  $cert_hostname = $parsed_trusted_cert_name['cert_hostname']
  $cert_domain = $parsed_trusted_cert_name['cert_domain']

  $parsed_classification = classification::parse_hostname($cert_hostname)
  $number = $parsed_classification['number']
  $parts = $parsed_classification['parts']
  [$group, $function, $number_string, $context, $stage, $id] = $parts

  if $parsed_classification['version'] == 2 {
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
  $root_level_calculated_trusted = {
    clientcert => $trusted['certname'],
    hostname   => $hostname,
    fqdn       => $fqdn,
    domain     => $domain,
  }

  $root_level_facts_to_validate = [
    'clientcert',
    'hostname',
    'fqdn',
    'domain',
  ]

  $classification_calculated_trusted = $parsed_classification + {
    hostname => $hostname,
  }

  $classification_facts_to_validate = [
    'hostname',
    'version',
    'group',
    'function',
    'number',
    'number_string',
    'context',
    'stage',
  ]

  $root_level_fact_differences = classification::validate_facts(
    $facts,
    $root_level_calculated_trusted,
    $root_level_facts_to_validate,
  )

  $classification_fact_differences = classification::validate_facts(
    $facts['classification'],
    $classification_calculated_trusted,
    $classification_facts_to_validate,
  )

  $fact_differences = $root_level_fact_differences + $classification_fact_differences
  classification::test_fact_difference_array($fact_differences)
}
