module Puppet::Parser::Functions
  require File.expand_path(
    '../../../puppetops/classification.rb',
    File.dirname(__FILE__))

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
  newfunction(:parse_hostname, :type => :rvalue) do |arguments|
    if arguments.size != 1
      raise(Puppet::ParseError,
        "parse_hostname(): Expected 1 argument; got #{arguments.size}")
    end

    hostname = arguments[0]
    if ! hostname.is_a?(String)
      raise(Puppet::ParseError,
        'parse_hostname(): Expected a string; got #{hostname.class.name}')
    end

    Puppetops::Classification::parse_hostname(hostname)
  end
end
