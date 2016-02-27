# encoding: utf-8

require 'rainbow'
require 'rexml/document'
require 'set'
require 'terminal-table'

require_relative 'application'
require_relative 'concept/ia'
require_relative 'concept/ia_calculate'
require_relative 'concept/ia_sequence'
require_relative 'concept/ia_table1field'
require_relative 'concept/ia_texts'
require_relative 'concept/lang'
require_relative 'concept/question'
require_relative 'concept/table'
require_relative 'tool'

class Concept
  include IA
  include IA_calculate
  include IA_sequence
  include IA_table1field
  include IA_texts
	
  attr_reader :id, :data, :num
  attr_accessor :process

  @@id=0

  def initialize(pXMLdata,lang="en")
    @lang=Lang.new(lang)
				
    @@id+=1
    @id=@@id
		
    @weights=Application.instance.formula_weights
    @output=true

    @data={}
    @data[:names]=[]
    @data[:context]=[]
    @data[:tags]=[]
    @data[:texts]=[]
    @data[:tables]=[]
    @data[:neighbors]=[]
	
	read_data_from_xml(pXMLdata)
	    
    @data[:misspelled]=misspelled_name
  end
	
  def name
    return @data[:names][0] || 'concept'+@@id.to_s
  end
	
  def hiden_name
    n=name
    s=""
    n.each_char do |c|
      if ' !|"@#$%&/()=?¿¡+*(){}[],.-_<>'.include? c then
        s=s+c
      else
        s=s+'?'
      end
    end
    return s
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
    out=" #{Rainbow(name).color(:white).bg(:blue).bright} (#{@id.to_s}) lang(#{@lang.lang})\n"

    t = Terminal::Table.new
    t.add_row [Rainbow(".context").color(:blue), context.join("\n").to_s ]
    t.add_row [Rainbow(".tags").color(:blue), tags.join("\n").to_s] 

    if text.size<60 then
	  t.add_row [Rainbow(".text").color(:blue), text.to_s]	  
	else
	  t.add_row [Rainbow(".text").color(:blue), text[0...60].to_s+"..."]
	end
	
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
        j=i.text.split(",")
        j.each { |k| @data[:context] << k.strip }
      when 'tags'
        j=i.text.split(",")
        j.each { |k| @data[:tags] << k.strip }
      when 'text'
        @data[:texts] << i.text.strip
      when 'table'				
        @data[:tables] << Table.new(self,i)
      else
        puts "[ERROR] XMLdata with #{i.name}"
      end
    end
  end
end
