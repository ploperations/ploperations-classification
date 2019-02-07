# @summary Validate a hash of facts against trusted values calculated from the certname.
#
# Validate a hash of facts against trusted values calculated from the certname.
#
# @example
#   $classification_calculated_trusted = $parsed_classification + {
#     hostname => $hostname,
#   }
#
#   $classification_facts_to_validate = [
#     'hostname',
#     'version',
#     'group',
#     'function',
#     'number',
#     'number_string',
#     'context',
#     'stage',
#   ]
#
#   $classification_fact_differences = classification::validate_facts(
#     $facts['classification'],
#     $classification_calculated_trusted,
#     $classification_facts_to_validate,
#   )
#
# @param untrusted_facts A hash of untrusted facts
# @param calculated_facts A hash of trusted facts
# @param fact_names An array of fact names to validate
# @return [Array] An array of strings documenting any facts that don't match their trusted values
function classification::validate_facts(
  Hash $untrusted_facts,
  Hash $calculated_facts,
  Array $fact_names,
  ) >> Array {
  $differences = delete_undef_values($fact_names.map |$fact_name| {
    $untrusted_value = String($untrusted_facts[$fact_name])
    $trusted_value = String($calculated_facts[$fact_name])

    if $untrusted_value != $trusted_value {
      "    ${fact_name}: '${untrusted_value}' != '${trusted_value}'"
    } else {
      undef
    }
  })

  $differences
}
