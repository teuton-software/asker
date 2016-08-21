# encoding: utf-8

class Row
  attr_reader :id, :cols, :langs, :types

  def initialize( pTable, order, pXMLdata )
    @table = pTable
    @order = order
    @id    = pTable.id + "." + order.to_s
    @cols  = []
    @langs = []
    @types = []
  end

private

end
