require File.expand_path(
  '../../../ploperations/classification.rb',
  File.dirname(__FILE__),
)

# Parse a hostname into a hash of its parts
Puppet::Functions.create_function(:'classification::parse_hostname') do
  # @summary Parse a hostname into a hash of its parts.
  #
  # Parse a hostname into a hash of its parts.
  #
  # @param hostname_string A hostname to parse
  # @return Some or all the values may be nil.
  # @example
  #   {
  #     hostname      => $hostname,
  #     parts         => [$group, $function, $number_string, $context, $stage, $id],
  #     group         => $group,
  #     function      => $function,
  #     number        => $number_as_int,
  #     number_string => $number_string,
  #     context       => $context,
  #     stage         => $stage,
  #     id            => $id,
  #   }
  dispatch :parse_hostname do
    param 'String', :hostname_string
    return_type 'Hash'
  end

  def parse_hostname(hostname_string)
    Ploperations::Classification.parse_hostname(hostname_string)
  end
end
