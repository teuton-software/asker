# encoding: utf-8

class Row
  attr_reader :id, :cols, :lang, :type

  def initialize(pTable, data=[])
    @table = pTable
    @cols  = []
    @langs = []
    @types = []

    @data  = data

  end

end
