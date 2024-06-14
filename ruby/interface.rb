# frozen_string_literal: true

class Interface
  NAME = /Ethernet\S+/
  ADDRESS = /\S+/
  SHUTDOWN = /shutdown/

  def initialize
    @parsed = {}
  end

  def parse(file)
    while (line = file.gets)
      case line
      when /^\s+ip address (#{ADDRESS})/
        @parsed[:address] = ::Regexp.last_match(1)
      when /^\s+#{SHUTDOWN}/
        @parsed[:shutdown] = 'shutdown'
      when /^!/
        return @parsed
      end
    end
  end
end
