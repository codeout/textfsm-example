# frozen_string_literal: true

require_relative 'parser'

if __FILE__ == $PROGRAM_NAME
  open('example.conf') do |f|
    pp Parser.new.parse(f)
  end
end
