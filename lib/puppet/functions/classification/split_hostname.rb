require File.expand_path(
  '../../../ploperations/classification.rb',
  File.dirname(__FILE__),
)

# Split a hostname into its consituent parts
Puppet::Functions.create_function(:'classification::split_hostname') do
  # @summary Split a hostname into its consituent parts.
  #
  # Split a hostname into its consituent parts.
  #
  # @param hostname_string A hostname to parse
  # @return Returns a 6 element array. Some or all the elements may be nil.
  # @example
  #   [ $group, $function, $number_string, $context, $stage, $id ]
  dispatch :split_hostname do
    param 'String', :hostname_string
    return_type 'Array'
  end

  def split_hostname(hostname_string)
    Ploperations::Classification.split_hostname(hostname_string)
  end
end
