module Puppetops
  module Classification
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
      when /^([a-z0-9]*[a-z][a-z0-9]*)-([a-z]+)(-[a-z0-9]*[a-z][a-z0-9]*)?-([a-z]+)-(\d+)(-[a-z0-9]+)?$/
        # group-function-context-stage-#-id
        group, function, stage, number_string = [$1, $2, $4, $5]
        version = 2

        # Strip hyphen. This is easier to read than doing it in the regex.
        # If the capture group is nil then the value will be set to nil.
        context = $3[1..-1] rescue nil.to_s
        id = $6[1..-1] rescue nil.to_s
      when /^([a-z-]+)-([a-z]+)(\d+)-([a-z]+)$/
        # group-function#-stage
        group, function, number_string, stage = [$1, $2, $3, $4]
        version = 1

        context = nil.to_s
        id = nil.to_s
      when /[0-9-]/
        # Replicate old group and stage facts
        group = hostname.split(/[0-9-]/).first
        stage = hostname.split(/-/).last rescue nil.to_s

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
      self._split_hostname(hostname)[0..5]
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
    # ~~~
    def self.parse_hostname(hostname)
      parts = self._split_hostname(hostname)
      version = parts.pop()
      group, function, number_string, context, stage, id = parts

      if number_string
        number = number_string.to_i
      else
        number = nil
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
end
