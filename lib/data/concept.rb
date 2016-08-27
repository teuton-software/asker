# encoding: utf-8

require 'rainbow'
require 'rexml/document'

require_relative '../project'
require_relative '../lang/lang_factory'
require_relative 'table'

class Concept

  attr_reader :id, :lang, :context
  attr_reader :names
  attr_reader :data
  attr_accessor :process

  @@id=0

  def initialize(pXMLdata, pFilename, langCode="en", pContext=[])
    @@id+=1
    @id=@@id

    @lang=LangFactory.instance.get(langCode)
    @process=false

    if pContext.class==Array then
      @context=pContext
    elsif pContext.nil? then
      @context=[]
    else
      @context=pContext.split(",")
      @context.collect! { |i| i.strip }
    end
    @names=[]

    @data={}
    @data[:filename]=pFilename

    @data[:tags]=[]
    @data[:texts]=[]
    @data[:images]=[] #TODO: By now, We'll treat images separated from texts
    @data[:tables]=[]
    @data[:neighbors]=[]
    @data[:reference_to]=[]
    @data[:referenced_by]=[]

	  read_data_from_xml(pXMLdata)
  end

  def name
    return @names[0] || 'concept.'+@@id.to_s
  end

  def text
    return @data[:texts][0] || '...'
  end

  def process?
    return @process
  end

  def try_adding_neighbor(other)
    p = calculate_nearness_to_concept(other)
    return if p==0
    @data[:neighbors]<< { :concept => other , :value => p }
    #Sort neighbors list
    @data[:neighbors].sort! { |a,b| a[:value] <=> b[:value] }
    @data[:neighbors].reverse!
  end

  def calculate_nearness_to_concept(other)
    weights=Project.instance.formula_weights

    liMax1=@context.count
    liMax2=@data[:tags].count
    liMax3=@data[:tables].count

    lfAlike1=lfAlike2=lfAlike3=0.0

    #check if exists this items from concept1 into concept2
    @context.each { |i| lfAlike1+=1.0 if !other.context.index(i).nil? }
    @data[:tags].each { |i| lfAlike2+=1.0 if !other.tags.index(i).nil? }
    @data[:tables].each { |i| lfAlike3+=1.0 if !other.tables.index(i).nil? }

    lfAlike = ( lfAlike1*weights[0] + lfAlike2*weights[1] + lfAlike3*weights[2] )
    liMax   = ( liMax1  *weights[0] + liMax2  *weights[1] + liMax3*weights[2]   )
    return ( lfAlike*100.0/ liMax )
  end

  def try_adding_references(other)
    reference_to=0
    @data[:tags].each { |i| reference_to+=1 if !other.names.index(i.downcase).nil? }
    @data[:texts].each do |t|
      text=t.clone
      text.split(" ").each do |word|
        reference_to+=1 if !other.names.index(word.downcase).nil?
      end
    end
    if reference_to>0 then
      @data[:reference_to] << other.name
      other.data[:referenced_by] << self.name
    end
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
        j.each { |k| @names << k.strip }
      when 'context'
        #DEPRECATED: Don't use xml tag <context> instead define it as attibute of root xml tag
        msg="   │  "+Rainbow(" [DEPRECATED] Concept ").yellow+Rainbow(name).yellow.bright+Rainbow(" use XMLtag <context>. Instead define it as root attibute.").yellow
        Project.instance.verbose msg
        @context=i.text.split(",")
        @context.collect! { |k| k.strip }
      when 'tags'
        @data[:tags]=i.text.split(",")
        @data[:tags].collect! { |k| k.strip }
      when 'text'
        #DEPRECATED: Use xml tag <def> instead of <text>
        msg="   │  "+Rainbow(" [DEPRECATED] Concept ").yellow+Rainbow(name).yellow.bright+Rainbow(" use XMLtag <text>, Instead use <def> tag.").yellow
        Project.instance.verbose msg
        @data[:texts] << i.text.strip
      when 'def'
        case i.attributes['type']
        when 'image'
          Project.instance.verbose Rainbow("[DEBUG] Concept#read_xml: image #{Rainbow(i.text).bright}").yellow
        when 'image_url'
          @data[:images] << i.text.strip
        else
          @data[:texts] << i.text.strip
        end
      when 'table'
        @data[:tables] << Table.new(self,i)
      else
        msg = Rainbow("   [ERROR] <#{i.name}> attribute into XMLdata (concept#read_data_from_xml)").color(:red)
        Project.instance.verbose msg
      end
    end
  end
end
