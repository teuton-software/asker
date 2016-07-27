# encoding: utf-8

require 'rexml/document'

require_relative '../project'
require_relative '../lang/lang'
require_relative '../tool'
require_relative 'table'

class Concept

  attr_reader :id, :data
  attr_accessor :process

  @@id=0

  def initialize(pXMLdata, pLang="en", pContext=[])
    @@id+=1
    @id=@@id

    @output=true

    @lang=Lang.new(pLang)
    @process=false

    @data={}
    @data[:names]=[]
    if pContext.class==Array then
      @data[:context]=pContext
    elsif pContext.nil? then
      @data[:context]=[]
    else
      @data[:context]=pContext.split(",")
      @data[:context].collect! { |i| i.strip }
    end
    @data[:tags]=[]
    @data[:texts]=[]
    @data[:images]=[]
    @data[:tables]=[]
    @data[:neighbors]=[]

	  read_data_from_xml(pXMLdata)

  end

  def name
    return @data[:names][0] || 'concept'+@@id.to_s
  end

  def text
    return @data[:texts][0] || '...'
  end

  def process?
    return @process
  end

  def calculate_nearness_to_concept(pConcept)
		weights = Project.instance.formula_weights

    liMax1=@data[:context].count
    liMax2=@data[:tags].count
    liMax3=@data[:tables].count

    lfAlike1=0.0
    lfAlike2=0.0
    lfAlike3=0.0

    @data[:context].each { |i| lfAlike1+=1.0 if !pConcept.context.index(i).nil? }
    @data[:tags].each { |i| lfAlike2+=1.0 if !pConcept.tags.index(i).nil? }
    @data[:tables].each { |i| lfAlike3+=1.0 if !pConcept.tables.index(i).nil? }

    lfAlike =(lfAlike1*weights[0]+lfAlike2*weights[1]+lfAlike3*weights[2])
    liMax = (liMax1*weights[0]+liMax2*weights[1]+liMax3*weights[2])
    return ( lfAlike*100.0/ liMax )
  end

  def try_adding_neighbor(pConcept)
    p = calculate_nearness_to_concept(pConcept)
    return if p==0
    @data[:neighbors]<< { :concept => pConcept , :value => p }
    #Sort neighbors list
    @data[:neighbors].sort! { |a,b| a[:value] <=> b[:value] }
    @data[:neighbors].reverse!
  end

  def method_missing(m, *args, &block)
    return @data[m]
  end

private

  def read_data_from_xml(pXMLdata)
    pXMLdata.elements.each do |i|
      case i.name
      when 'names'
        j=i.text.split(",")
        j.each { |k| @data[:names] << k.strip }
      when 'tags'
        @data[:tags]=i.text.split(",")
        @data[:tags].collect! { |k| k.strip }
      when 'def'
        if i.attributes['image']
          msg = Rainbow("[DEBUG] Concept#read_data_from_xml: #{Rainbow(i.attributes['image']).bright}").yellow
          Tool.instance.verbose msg
          @data[:images] << i.attributes['image'].strip
        else
          @data[:texts] << i.text.strip
        end
      when 'table'
        @data[:tables] << Table.new(self,i)
      else
        msg = Rainbow("   [ERROR] <#{i.name}> attribute into XMLdata (concept#read_data_from_xml)").color(:red)
        Tool.instance.verbose msg
      end
    end
  end
end
