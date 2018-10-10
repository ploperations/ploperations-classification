require File.expand_path(
  '../ploperations.rb',
  File.dirname(__FILE__),
)

# This module generates facts based off of a nodes's name
# rubocop:disable Style/PerlBackrefs
module Ploperations::Classification
  # Same as split_hostname, but returns an extra version value.
  #
  # The version value will be one of:
  #   * `2`: hostname matches group-function-context-stage-#-id
  #   * `1`: hostname matches group-function#-stage
  #   * `0`: hostname doesn't match one of the standards
  def self._split_hostname(hostname)
    group, function, number_string, context, stage, id = []
    version = 0

    case hostname
    when %r{^([a-z0-9]*[a-z][a-z0-9]*)-([a-z]+)(-[a-z0-9]*[a-z][a-z0-9]*)?-([a-z]+)-(\d+)(-[a-z0-9]+)?$}
      version = 2
      # group-function-context-stage-#-id
      group = $1
      function = $2
      stage = $4
      number_string = $5

      # Strip hyphen. This is easier to read than doing it in the regex.
      # If the capture group is nil then the value will be set to nil.
      begin
        context = $3[1..-1]
      rescue
        context = nil.to_s
      end

      begin
        id = $6[1..-1]
      rescue
        nil.to_s
      end

    when %r{^([a-z-]+)-([a-z]+)(\d+)-([a-z]+)$}
      version = 1
      # group-function#-stage
      group = $1
      function = $2
      number_string = $3
      stage = $4

      context = nil.to_s
      id = nil.to_s
    when %r{[0-9-]}
      # Replicate old group and stage facts
      group = hostname.split(%r{[0-9-]}).first

      begin
        stage = hostname.split(%r{-}).last
      rescue
        stage = nil.to_s
      end

      # set remaining parts of the fact so they are not undefined
      function = nil.to_s
      number_string = nil.to_s
      context = nil.to_s
      id = nil.to_s
    end

    [group, function, number_string, context, stage, id, version]
  end

  # Split a hostname into its consituent parts
  #
  # Returns a 6 element array. Some or all the elements may be nil.
  #
  # ~~~ ruby
  # return [group, function, number_string, context, stage, id]
  # ~~~~
  def self.split_hostname(hostname)
    # Drop the version element
    _split_hostname(hostname)[0..5]
  end

  # Parse a hostname into a hash of its parts
  #
  # Returns a hash. Some or all the values may be nil.
  #
  # The version attribute will be one of:
  #   * `2`: hostname matches group-function-context-stage-#-id
  #   * `1`: hostname matches group-function#-stage
  #   * `0`: hostname doesn't match one of the standards
  #
  # ~~~ ruby
  # return {
  #   'hostname' => hostname,
  #   'parts' => [group, function, number_string, context, stage, id],
  #   'version' => version,
  #   'group' => group,
  #   'function' => function,
  #   'number' => number,
  #   'number_string' => number_string,
  #   'context' => context,
  #   'stage' => stage,
  #   'id' => id,
  # }
  #
  def self.parse_hostname(hostname)
    parts = _split_hostname(hostname)
    version = parts.pop
    group, function, number_string, context, stage, id = parts

    number = if number_string
               number_string.to_i
             else
               nil
             end

    {
      'hostname' => hostname,
      'parts' => parts,
      'version' => version,
      'group' => group,
      'function' => function,
      'number' => number,
      'number_string' => number_string,
      'context' => context,
      'stage' => stage,
      'id' => id,
    }
  end
end
