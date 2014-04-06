# encoding: utf-8

require 'rexml/document'
require 'set'
require_relative 'interviewer'
require_relative 'question'

class Concept
	attr_reader :id, :data
	attr_accessor :process

	@@id=0

	def initialize(pXMLdata)
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
		s=s+" <"+name+"("+@id.to_s+")>\n"
		s=s+"  .context    = "+context.to_s+"\n" if context.count>0
		s=s+"  .tags       = "+tags.to_s+"\n"
		s=s+"  .text       = "+text[0..60].to_s+"...\n"
		s=s+"  .tables     = "+tables.to_s+"\n" if tables.count>0
		s=s+"  .neighbors  = "
		neighbors.each { |i| s=s+i[:concept].name+"("+i[:value].to_s[0..4]+") " }
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
	

private

	def process_texts	
		q=Question.new
		texts.each do |t|
			s=Set.new [name, "Ninguna es correcta"]
			neighbors.each { |n| s.add n[:concept].name } 
			a=s.to_a
				
			if s.count>3 then
				@num+=1
				q.name="#{name}-#{@num.to_s}a1-desc"
				q.text="Definición\: \"#{t}\"<br/>Elige la opción que mejor se corresponda con la definición anterior.<br/>"
				q.good=name
				q.bads << "Ninguna es correcta"
				q.bads << a[2]
				q.bads << a[3]
				q.write_to_file @file
			end
			
			s.delete(name)
			a=s.to_a
			
			if s.count>3 then
				@num+=1
				q.init
				q.name="#{name}-#{@num.to_s}a2-desc"
				q.text="Definición\: \"#{t}\"<br/>Elige la opción que mejor se corresponda con la definición anterior.<br/>"
				q.good="Ninguna es correcta"
				q.bads << a[1]
				q.bads << a[2]
				q.bads << a[3]
				q.write_to_file @file
			end
			
			@num+=1
			q.init
			q.set_boolean
			q.name="#{name}-#{@num.to_s}a3-desc"
			q.text="Definición de #{name}\:<br/> \"#{t}\"<br/>"
			q.good="TRUE"
			q.write_to_file @file

			if neighbors.count>0 then
				@num+=1
				q.init
				q.set_boolean
				q.name="#{name}-#{@num.to_s}a4-desc"
				q.text="Definición de #{neighbors[0][:concept].name}\:<br/> \"#{t}\"<br/>"
				q.good="FALSE"
				q.write_to_file @file
			end
		end
	end

	def process_table_match(pTable, pList1, pList2)
		return if pTable.fields.count<2
		if pTable.fields.count>1 then
			process_table_match2fields(pTable, pList1, pList2, 0, 1)
		elsif pTable.fields.count>2 then
			process_table_match2fields(pTable, pList1, pList2, 0, 2)
			process_table_match2fields(pTable, pList1, pList2, 1, 2)
		elsif pTable.fields.count>3 then
			process_table_match2fields(pTable, pList1, pList2, 0, 3)
			process_table_match2fields(pTable, pList1, pList2, 1, 3)
			process_table_match2fields(pTable, pList1, pList2, 2, 3)
		end
	end
	
	def process_table_match2fields(pTable, pList1, pList2, pIndex1, pIndex2)
		q=Question.new
		if pList1.count>3 then
			@num+=1
			q.init
			q.set_match
			q.name="#{name}-#{@num.to_s}b1-match-#{pTable.name}"
			q.text="Asocia cada #{pTable.fields[pIndex1].capitalize} con su #{pTable.fields[pIndex2].capitalize}<br/>."
			q.matching << [ pList1[0][:data][pIndex1], pList1[0][:data][pIndex2] ]
			q.matching << [ pList1[1][:data][pIndex1], pList1[1][:data][pIndex2] ]
			q.matching << [ pList1[2][:data][pIndex1], pList1[2][:data][pIndex2] ]
			q.matching << [ pList1[3][:data][pIndex1], pList1[3][:data][pIndex2] ]
			q.write_to_file @file
		elsif pList1.count==3 and pList2.count>0 then
			@num+=1
			q.init
			q.set_match
			q.name="#{name}-#{@num.to_s}b2-match-#{pTable.name}"
			q.text="Asocia cada #{pTable.fields[pIndex1].capitalize} con su #{pTable.fields[pIndex2].capitalize}<br/>."
			q.matching << [ pList1[0][:data][pIndex1], pList1[0][:data][pIndex2] ]
			q.matching << [ pList1[1][:data][pIndex1], pList1[1][:data][pIndex2] ]
			q.matching << [ pList1[2][:data][pIndex1], pList1[2][:data][pIndex2] ]
			q.matching << [ pList2[0][:data][pIndex1], pList2[0][:data][pIndex2] ]
			q.write_to_file @file			
		end
	end
	
	def process_tableXfields(pTable, pRow, pList)
		return if pTable.fields.count<2
		if pTable.fields.count>1 then
			process_table2fields(pTable, pRow, pList, 0, 1)
		elsif pTable.fields.count>2 then
			process_table2fields(pTable, pRow, pList, 0, 2)
			process_table2fields(pTable, pRow, pList, 1, 2)
		elsif pTable.fields.count>3 then
			process_table2fields(pTable, pRow, pList, 0, 3)
			process_table2fields(pTable, pRow, pList, 1, 3)
			process_table2fields(pTable, pRow, pList, 2, 3)
		end
	end

	def process_table2fields(lTable, lRow, pList, pCol1, pCol2)
		q=Question.new	

		#create gift questions	
		s=Set.new [ lRow[:data][0] , "Ninguna es correcta" ]
		pList.each { |i| s.add( i[:data][0] ) }
		a=s.to_a
		
		if s.count>3 then		
			@num+=1
			q.init
			q.name="#{name}-#{@num.to_s}c1-#{lTable.name}"
			q.text="Concepto #{name}:<br/>#{lTable.fields[0].capitalize}\: [...]<br/>#{lTable.fields[1].capitalize}: \"#{lRow[:data][1]}\"<br/>Completa con la opción correcta."
			q.good=lRow[:data][0]
			q.bads << "Ninguna es correcta"
			q.bads << a[2]
			q.bads << a[3]
			q.write_to_file @file		
		end
				
		s=Set.new [ lRow[:data][0], "Ninguna es correcta" ]
		pList.each { |i| s.add( i[:data][0] ) }
		a=s.to_a

		if s.count>4 then
			@num+=1
			q.init
			q.name="#{name}-#{@num.to_s}c2-#{lTable.name}"
			q.text="Concepto #{name}:<br/>#{lTable.fields[0].capitalize}\: [...]<br/>#{lTable.fields[1].capitalize}: \"#{lRow[:data][1]}\"<br/>Completa con la opción correcta."
			q.good="Ninguna es correcta"
			q.bads << a[2]
			q.bads << a[3]
			q.bads << a[4]
			q.write_to_file @file
		end

		s=Set.new [ lRow[:data][1], "Ninguna es correcta" ]
		pList.each { |i| s.add( i[:data][1] ) }
		a=s.to_a

		if s.count>3 then			
			@num+=1
			q.init
			q.name="#{name}-#{@num.to_s}c3-#{lTable.name}"
			q.text="Concepto #{name}:<br/>#{lTable.fields[0].capitalize}\: \"#{lRow[:data][0]}\"<br/>#{lTable.fields[1].capitalize}\: [...]<br/>Completa con la opción correcta."
			q.good=a[0]
			q.bads << "Ninguna es correcta"
			q.bads << a[2]
			q.bads << a[3]
			q.write_to_file @file		
		end
		
		s=Set.new [ lRow[:data][1], "Ninguna es correcta" ]
		pList.each { |i| s.add( i[:data][1] ) }
		a=s.to_a

		if s.count>4 then			
			@num+=1
			q.init
			q.name="#{name}-#{@num.to_s}c4-#{lTable.name}"
			q.text="Concepto #{name}:<br/>#{lTable.fields[0].capitalize}\: \"#{lRow[:data][0]}\"<br/>#{lTable.fields[1].capitalize}\: [...]<br/>Completa con la opción correcta."
			q.good="Ninguna es correcta"
			q.bads << a[2]
			q.bads << a[3]
			q.bads << a[4]
			q.write_to_file @file
		end

		@num+=1
		q.init
		q.set_boolean
		q.name="#{name}-#{@num.to_s}c5-#{lTable.name}"
		q.text="Concepto #{name}:<br/>La asociación siguiente es correcta\:<br/>#{lTable.fields[0].capitalize}\: \"#{lRow[:data][0]}\"<br/>#{lTable.fields[1].capitalize}\: #{lRow[:data][1]}<br/>."
		q.good="TRUE"
		q.write_to_file @file

		s=Set.new [ lRow[:data][1] ]
		pList.each { |i| s.add( i[:data][1] ) }
		a=s.to_a

		if s.count>1 then		
			@num+=1
			q.init
			q.set_boolean
			q.name="#{name}-#{@num.to_s}c6-#{lTable.name}"
			q.text="Concepto #{name}:<br/>La asociación siguiente es correcta\:<br/>#{lTable.fields[0].capitalize}\: \"#{lRow[:data][0]}\"<br/>#{lTable.fields[1].capitalize}\: \"#{a[1]}\"<br/>."
			q.good="FALSE"
			q.write_to_file @file
		end
		
		s=Set.new [ lRow[:data][0] ]
		pList.each { |i| s.add( i[:data][0] ) }
		a=s.to_a

		if s.count>1 then
			@num+=1
			q.init
			q.set_boolean
			q.name="#{name}-#{@num.to_s}c7-#{lTable.name}"
			q.text="Concepto #{name}:<br/>La asociación siguiente es correcta\:<br/>#{lTable.fields[0].capitalize}\: \"#{a[1]}\"<br/>#{lTable.fields[1].capitalize}\: \"#{lRow[:data][1]}\"<br/>."
			q.good="FALSE"
			q.write_to_file @file
		end
	end
		
	def reorder_list_with_row(pList, pRow)
		#evaluate every row of the list2
		pList.each do |lRow|
			if lRow[:id]==pRow[:id] then
				lRow[:weight]=-300
			else
				val=0
				s=pRow[:data].count
				s.times do |i|
					val=val+calculate_nearness_between_texts(pRow[:data][i],lRow[:data][i])
				end
				val=val/s
				lRow[:weight]=val
			end
		end
		pList.sort! { |a,b| a[:weight] <=> b[:weight] }
		pList.reverse!
	end
	
	def calculate_nearness_between_texts(pText1, pText2)
		words=pText1.split(" ")
		count=0
		words.each do |w|
			count +=1 if pText2.include? w
		end
		return (count*100/words.count)
	end	

	def calculate_nearness_to_concept(pConcept)
		liMax1=@data[:context].count
		liMax2=@data[:tags].count
		liMax3=@data[:tables].count

		lfAlike1=0.0
		lfAlike2=0.0
		lfAlike3=0.0
		
		@data[:context].each { |i| lfAlike1+=1.0 if !pConcept.context.index(i).nil? }	
		@data[:tags].each { |i| lfAlike2+=1.0 if !pConcept.tags.index(i).nil? }
		@data[:tables].each { |i| lfAlike3+=1.0 if !pConcept.tables.index(i).nil? }	

		lfAlike =(lfAlike1*@weights[0]+lfAlike2*@weights[1]+lfAlike3*@weights[2])
		liMax = (liMax1*@weights[0]+liMax2*@weights[1]+liMax3*@weights[2]) 
		return ( lfAlike*100.0/ liMax )
	end

	def not_equals(a,b,c,d)
		return (a!=b && a!=c && a!=d && b!=c && b!=d && c!=d)
	end
end

class Table
	attr_reader :name, :data

	def initialize(pConcept, pXMLdata)
		@concept=pConcept
		@name=""

		@data={}
		@data[:fields]=[]
		@data[:title]=[]
		@data[:rows]=[]
		
		@data[:fields]=pXMLdata.attributes['fields'].to_s.strip.split(',')
		@data[:fields].each { |i| i.strip! }
		@data[:fields].each { |i| @name=@name+"$"+i.to_s.strip.downcase} 
		
		pXMLdata.elements.each do |i|
			if i.name=='title' then
				@data[:title] << i.text.strip
			elsif i.name=='row' then
				row=[]
				i.elements.each { |j| row << j.text.to_s}
				@data[:rows] << row
			else
				puts "[ERROR] XMLdata with #{i.name}"
			end
		end
	end
	
	def fields
		return @data[:fields]
	end
	
	def rows
		return @data[:rows]
	end
	
	def to_s
		@name.to_s
	end
	
end	

