# frozen_string_literal: true

require_relative 'address_family'

class Bgp
  ASN = /\d+/
  ROUTER_ID = /\S+/
  PEER_GROUP = /\S+/
  NEIGHBOR = /\S+/

  def initialize
    @parsed = []
    @router_id = nil
  end

  def parse(file)
    while (line = file.gets)
      case line
      when /^\s+router-id (#{ROUTER_ID})/
        @router_id = ::Regexp.last_match(1)
      when /^\s+neighbor (#{NEIGHBOR}) peer group (#{PEER_GROUP})/
        @parsed << { router_id: @router_id, neighbor: ::Regexp.last_match(1), peer_group: ::Regexp.last_match(2) }
      when /^\s+address-family (#{AddressFamily::ADDRESS_FAMILY})/
        @parsed << { router_id: @router_id,
                     address_family: ::Regexp.last_match(1) }.merge(AddressFamily.new.parse(file))
      when /^!/
        return @parsed
      end
    end
  end
end
