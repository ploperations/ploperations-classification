module Puppet::Parser::Functions
  require File.expand_path(
    '../../../puppetops/classification.rb',
    File.dirname(__FILE__))

  # Split a hostname into its consituent parts
  #
  # Returns a 6 element array. Some or all the elements may be nil.
  #
  # [ $group, $function, $number_string, $context, $stage, $id ]
  newfunction(:split_hostname, :type => :rvalue) do |arguments|
    if arguments.size != 1
      raise(Puppet::ParseError,
        "split_hostname(): Expected 1 argument; got #{arguments.size}")
    end

    hostname = arguments[0]
    if ! hostname.is_a?(String)
      raise(Puppet::ParseError,
        'split_hostname(): Expected a string; got #{hostname.class.name}')
    end

    Puppetops::Classification::split_hostname(hostname)
  end
end
