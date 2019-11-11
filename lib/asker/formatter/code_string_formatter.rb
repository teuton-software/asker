# encoding: utf-8

require 'rainbow'
require 'terminal-table'

# Define methods to trasnforme FOB into String
module CodeStringFormatter
  def self.to_s(fob)
    out = ''

    t = Terminal::Table.new
    msg = Rainbow(fob.filename).white.bg(:blue).bright
    t.add_row [Rainbow('FOB').bright, msg]
    t.add_row [Rainbow('Type').blue, fob.type.to_s]
    t.add_row [Rainbow('Lines').blue, fob.lines_to_s(fob.lines)]

    out << t.to_s + "\n"
    out
  end
end
