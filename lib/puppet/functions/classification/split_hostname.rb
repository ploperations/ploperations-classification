require File.expand_path(
  '../../../ploperations/classification.rb',
  File.dirname(__FILE__),
)

# /etc/puppetlabs/code/environments/production/modules/classification/lib/puppet/functions/classification
# Split a hostname into its consituent parts
#
# Returns a 6 element array. Some or all the elements may be nil.
#
# [ $group, $function, $number_string, $context, $stage, $id ]
Puppet::Functions.create_function(:'classification::split_hostname') do
  dispatch :split_hostname do
    param 'String', :hostname_string
    return_type 'Array'
  end

  def split_hostname(hostname_string)
    Ploperations::Classification.split_hostname(hostname_string)
  end
end
