# frozen_string_literal: true

class AddressFamily
  ADDRESS_FAMILY = /\S+/
  NEIGHBOR = /\S+/

  def initialize
    @parsed = {}
  end

  def parse(file)
    while (line = file.gets)
      case line
      when /^\s+neighbor (#{NEIGHBOR}) activate/
        @parsed[:neighbor] = ::Regexp.last_match(1)
      when /^\s+!/
        return @parsed
      end
    end
  end
end
