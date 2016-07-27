# encoding: utf-8

require 'rainbow'
require 'rexml/document'
require 'set'
require 'terminal-table'

require_relative '../lang/lang'
require_relative '../project'
require_relative '../tool'
require_relative 'ia'
require_relative 'question'
require_relative 'table'

class Concept
  include IA

  attr_reader :id, :data
  attr_reader :num
  attr_accessor :process

  @@id=0

  def initialize(pXMLdata, pFilename, pLang="en", pContext=[])
    @@id+=1
    @id=@@id
    @num = 0 #Number of questions. Used by <tool/show_actions> module

    @weights=Project.instance.formula_weights
    @output=true

    @filename=pFilename
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

    @data[:misspelled]=misspelled_name
  end

  def name
    return @data[:names][0] || 'concept'+@@id.to_s
  end

  def misspelled_name
    i=rand(name.size+1)
    j=i
    j=rand(name.size+1) while(j==i)

    lName=name+i.to_s
    #lName[i]=name[j]
    #lName[j]=name[i]
    return lName
  end

  def text
    return @data[:texts][0] || '...'
  end

  def process?
    return @process
  end

  def try_adding_neighbor(pConcept)
    p = calculate_nearness_to_concept(pConcept)
    return if p==0
    @data[:neighbors]<< { :concept => pConcept , :value => p }
    #Sort neighbors list
    @data[:neighbors].sort! { |a,b| a[:value] <=> b[:value] }
    @data[:neighbors].reverse!
  end

  def to_s
    out=""

    t = Terminal::Table.new
    t.add_row [Rainbow(@id.to_s).bright, Rainbow(name).color(:white).bg(:blue).bright+" (lang=#{@lang.lang}) " ]
    t.add_row [Rainbow("Filename").color(:blue), @filename.to_s ]
    t.add_row [Rainbow("Context").color(:blue), context.join(", ").to_s ]
    t.add_row [Rainbow("Tags").color(:blue), tags.join(", ").to_s]

    lText=[]
    texts.each do |i|
      if i.size<60 then
	    lText << i.to_s
	  else
	    lText << i[0...70].to_s+"..."
	  end
	end
    t.add_row [Rainbow(".def(text)").color(:blue), lText.join("\n")]
    t.add_row [Rainbow(".def(images)").color(:blue), images.join(", ").to_s]

	if tables.count>0 then
	  lText=[]
	  tables.each { |i| lText << i.to_s }
	  t.add_row [ Rainbow(".tables").color(:blue), lText.join("\n")]
	end

	lText=[]
	neighbors[0..5].each { |i| lText << i[:concept].name+"("+i[:value].to_s[0..4]+")" }
	t.add_row [Rainbow(".neighbors").color(:blue),lText.join("\n")]

    out << t.to_s+"\n"
	return out
  end

  def write_questions_to(pFile)
    @file=pFile
    @file.write "\n// Concept name: #{name}\n"

    @num=0
    #IA process every <text> definition
    process_texts

    #IA process every table of this concept
    tables.each do |lTable|
      #create <list1> with all the rows from the table
      list1=[]
      count=1
      lTable.rows.each do |i|
        list1 << { :id => count, :name => @name, :weight => 0, :data => i }
        count+=1
      end

      #create a <list2> with similar rows (same table name) from the neighbours
      list2=[]
      @data[:neighbors].each do |n|
        n[:concept].tables.each do |t2|
          if t2.name==lTable.name then
            t2.rows.each do |i|
              list2 << { :id => count, :name => n[:concept].name, :weight => 0, :data => i }
              count+=1
            end
          end
        end
      end

      list3=list1+list2
      process_table_match(lTable, list1, list2)
      process_table1field(lTable, list1, list2)
      process_sequence(lTable, list1, list2)

      list1.each do |lRow|
        reorder_list_with_row(list3, lRow)
        process_tableXfields(lTable, lRow, list3)
      end
    end
  end

  def to_doc
    out="\n"+"="*60+"\n"
    out << name+":\n\n"
    texts.each { |i| out << "* "+i+"\n" }
    out << "\n"

    tables.each do |t|
      my_screen_table = Terminal::Table.new do |st|
        st << t.fields
        st << :separator
        t.rows.each { |r| st.add_row r }
      end
      out << my_screen_table.to_s+"\n"
    end

    return out
  end

  def write_lesson_to(pFile)
    pFile.write(self.to_doc)
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
      when 'context'
        #DEPRECATED: Don't use xml tag <context> instead define it as attibute of root xml tag
        msg="   │  "+Rainbow(" [DEPRECATED] Concept ").yellow+Rainbow(name).yellow.bright+Rainbow(" use XMLtag <context>. Instead define it as root attibute.").yellow
        Project.instance.verbose msg
        @data[:context]=i.text.split(",")
        @data[:context].collect! { |k| k.strip }
      when 'tags'
        @data[:tags]=i.text.split(",")
        @data[:tags].collect! { |k| k.strip }
      when 'text'
        #DEPRECATED: Use xml tag <def> instead of <text>
        msg="   │  "+Rainbow(" [DEPRECATED] Concept ").yellow+Rainbow(name).yellow.bright+Rainbow(" use XMLtag <text>, Instead use <def> tag.").yellow
        Project.instance.verbose msg
        @data[:texts] << i.text.strip
      when 'def'
        if i.attributes['image']
          Project.verbose Rainbow("[DEBUG] Concept#read_data_from_xml: #{Rainbow(i.attributes['image']).bright}").yellow
          @data[:images] << i.attributes['image'].strip
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
