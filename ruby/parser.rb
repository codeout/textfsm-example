# frozen_string_literal: true

require_relative 'bgp'
require_relative 'interface'

class Parser
  def initialize
    @parsed = {}
  end

  def parse(file)
    while (line = file.gets)
      case line
      when /^interface (#{Interface::NAME})/
        @parsed[:interfaces] ||= []
        @parsed[:interfaces] << { name: ::Regexp.last_match(1) }.merge(Interface.new.parse(file))
      when /^router bgp (#{Bgp::ASN})/
        @parsed[:bgp] ||= []
        @parsed[:bgp] << Bgp.new.parse(file).map do |d|
          { asn: ::Regexp.last_match(1) }.merge(d)
        end
      end
    end

    @parsed
  end
end
