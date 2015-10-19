# encoding: utf-8

require 'rexml/document'
require 'set'
require_relative 'interviewer'
require_relative 'ia'

class Concept
	include IA
	
	attr_reader :id, :data, :num
	attr_accessor :process

	@@id=0

	def initialize(pXMLdata)
		@lang=Interviewer.instance.lang
				
		@@id+=1
		@id=@@id
		
		@weights=Interviewer.instance.param[:formula_weights]
		@output=true

		@data={}
		@data[:names]=[]
		@data[:context]=[]
		@data[:tags]=[]
		@data[:texts]=[]
		@data[:tables]=[]
		@data[:neighbors]=[]
		
		pXMLdata.elements.each do |i|
			if i.name=='names' then
				j=i.text.split(",")
				j.each { |k| @data[:names] << k.strip }
			elsif i.name=='context' then
				j=i.text.split(",")
				j.each { |k| @data[:context] << k.strip }
			elsif i.name=='tags' then
				j=i.text.split(",")
				j.each { |k| @data[:tags] << k.strip }
			elsif i.name=='text' then
				@data[:texts] << i.text.strip
			elsif i.name=='table' then				
				@data[:tables] << Table.new(self,i)
			else
				puts "[ERROR] XMLdata with #{i.name}"
			end
		end
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
	
	def names
		return @data[:names]
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
	
	def context
		return @data[:context]
	end

	def tags
		return @data[:tags]
	end
	
	def text
		return @data[:texts][0] || '...'
	end
	
	def texts
		return @data[:texts]
	end
	
	def tables
		return @data[:tables]
	end
	
	def neighbors
		return @data[:neighbors]
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
    s=""
    s=s+" <#{name}(#{@id.to_s})> lang=#{@lang.lang}\n"
    s=s+"  .context    = "+context.join(', ').to_s+"\n" if context.count>0
    s=s+"  .tags       = "+tags.join(', ').to_s+"\n"
    if text.size<60 then
	  s=s+"  .text       = "+text.to_s+"...\n"
	else
	  s=s+"  .text       = "+text[0...60].to_s+"...\n"
	end
	
	if tables.count>0 then
	  s=s+"  .tables     = "
	  tables.each { |t| s=s+t.to_s }
	  s= s +"\n"
	end
	
	s=s+"  .neighbors  = "
	n=[]
	neighbors[0..5].each { |i| n << i[:concept].name+"("+i[:value].to_s[0..4]+")" }
	s=s+n.join(', ').to_s
	return s
  end
	
	def write_questions_to(pFile)
		@file=pFile
		@file.write "\n// Concept name: #{name}\n"

		@num=0
		process_texts
		
		#process every table of this concept
		tables.each do |lTable|
			
			#create list1 with all the rows from the table
			list1=[]
			count=1
			lTable.rows.each do |i|
				list1 << { :id => count, :name => @name, :weight => 0, :data => i }
				count+=1
			end
			
			#create a list2 with similar rows from the neighbours
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
					
			list1.each do |lRow|
				reorder_list_with_row(list3, lRow)
				process_tableXfields(lTable, lRow, list3)
			end
		end		
	end
	
	def write_lesson_to(pFile)
		pFile.write("\n"+"="*30+"\n")
		pFile.write(name+"\n")
		
		texts.each { |i| pFile.write("* "+i+"\n") }

		tables.each do |t|
			s=""
			t.fields.each { |f| s=s+f.capitalize+Interviewer.instance.param[:lesson_separator] }
			pFile.write("\n"+s.chop+"\n")
			t.rows.each do |r|
				s=""
				r.each { |c| s=s+c+Interviewer.instance.param[:lesson_separator] }
				pFile.write("- "+s.chop+"\n") 
			end
		end
	end
	
end
