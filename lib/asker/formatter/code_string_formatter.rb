# frozen_string_literal: true

require 'rainbow'
require 'terminal-table'

# Define methods to trasnforme Code object into String
module CodeStringFormatter
  def self.to_s(code)
    t = Terminal::Table.new
    msg = Rainbow(code.filename).white.bg(:blue).bright
    t.add_row [Rainbow('Code').bright, msg]
    t.add_row [Rainbow('Type').blue, code.type.to_s]
    t.add_row [Rainbow('Lines').blue, code.lines_to_s(code.lines)]
    "#{t}\n"
  end
end
