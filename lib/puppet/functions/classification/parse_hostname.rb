require File.expand_path(
  '../../../ploperations/classification.rb',
  File.dirname(__FILE__),
)

# /etc/puppetlabs/code/environments/production/modules/classification/lib/puppet/functions/classification
# Parse a hostname into a hash of its parts
#
# Returns a hash. Some or all the values may be nil.
#
# {
#   hostname      => $hostname,
#   parts         => [$group, $function, $number_string, $context, $stage, $id],
#   group         => $group,
#   function      => $function,
#   number        => $number_as_int,
#   number_string => $number_string,
#   context       => $context,
#   stage         => $stage,
#   id            => $id,
# }
Puppet::Functions.create_function(:'classification::parse_hostname') do
  dispatch :parse_hostname do
    param 'String', :hostname_string
    return_type 'Hash'
  end

  def parse_hostname(hostname_string)
    Ploperations::Classification.parse_hostname(hostname_string)
  end
end
