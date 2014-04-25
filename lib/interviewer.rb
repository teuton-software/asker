#!/usr/bin/ruby
# encoding: utf-8
#

require 'singleton'
require 'yaml'
require 'haml'
require 'rexml/document'
require_relative 'concept'

=begin
The main method of Interviewer class is "run"

Interviewer.run do the next actions:
1) Read the configuration parameter values.
2) Read XML files from the directories indicated by "inputdirs" values.
3) Process the contents and definitions from this XML files.
4) Create GIFT questions from this contens and save it into the file 
indicated by "outputdir/outputname" values.

=end

class Interviewer
	include Singleton
	attr_reader :param
	
	def run(pArgs={})
		init pArgs
		load_input_files
		show_data if @param[:show_mode]!=:none
		create_output_file
		show_stats
	end
	
	def init(pArgs={})
		if pArgs.class==Hash then
			@param=pArgs
		elsif pArgs.class==String then
			@param=YAML::load(File.open(pArgs))
		else
			raise "[ERROR] Configuration params format is <#{pArgs.class.to_s}>!"
		end
		
		@param[:category]=@param[:category] || :none
		@param[:formula_weights]=@param[:formula_weights] || [1,1,1]
		@param[:inputdirs]=@param[:inputdirs] || 'input/default'
		@param[:lang]= @param[:lang] || 'es'
		@param[:outputdir]=@param[:outputdir] || 'output'
		@param[:process_file]=@param[:process_file] || 'default.xml'
		if @param[:process_file]=='default.xml' then
			@param[:outputname]=@param[:outputname] || 'default-gift.txt'
		else
			@param[:outputname]=@param[:outputname] || @param[:process_file].gsub('.xml','.txt')
		end
		@param[:logname]=@param[:logname] || 'default.log'
		@param[:lesson_file]=@param[:lesson_file] || 'default-lesson.txt'
		@param[:lesson_separator]=@param[:lesson_separator] || ' |'
		@param[:show_mode]=@param[:show_mode] || :default
		@param[:verbose]=@param[:verbose] || true

		@concepts={}
		
		@verbose=@param[:verbose]
		@logname=@param[:outputdir]+'/'+@param[:logname]
		@outputname=@param[:outputdir]+'/'+@param[:outputname]

		#create or reset logfile
		Dir.mkdir(@param[:outputdir])	if !Dir.exists? @param[:outputdir]

		@logfile=File.open(@logname,'w')
		@logfile.write("="*32+"\n")
		@logfile.write("Proyect: TeacherTools\n")
		@logfile.write("File: #{@logname}\n")
		@logfile.write("Time: "+Time.new.to_s+"\n")
		@logfile.write("="*32+"\n")
	end

	def load_input_files
		verbose "\n[INFO] Loading input data..."
		
		inputdirs=@param[:inputdirs].split(',')
		
		inputdirs.each do |dirname|
			if !Dir.exists? dirname then
				raise "[ERROR] <#{dirname}> directory dosn't exist!"
			end
			files=(Dir.new(dirname).entries-[".",".."]).sort
			filter = files.select { |f| f[-4..-1]==".xml" || f[-5..-1]==".haml" }
			verbose "* HAML/XML files from #{dirname}: #{filter.join(', ').to_s} "
		
			filter.each do |f|
				pFilename=dirname+'/'+f
				if pFilename[-5..-1]==".haml" then
					template = File.read(pFilename)
					haml_engine = Haml::Engine.new(template)
					lFileContent = haml_engine.render
				else
					lFileContent=open(pFilename) { |i| i.read }				
				end
				
				begin
					lXMLdata=REXML::Document.new(lFileContent)
					@param[:lang]=lXMLdata.root.attributes['lang'] || @param[:lang]
					
					lXMLdata.root.elements.each do |i|
						if i.name=='concept' then
							c=Concept.new(i)
							c.lang=@param[:lang]
							c.process=false
							if ( @param[:process_file]==:default or @param[:process_file]==f.to_s ) then
								c.process=true
							end
							@concepts[c.name]=c
						end
					end
				rescue REXML::ParseException
					verbose "[ERROR] Format error in file <"+pFilename+">!"
					raise "[ERROR] Format error in file <"+pFilename+">!"
				end
			end
		end
		
		#find neighbors
		@concepts.each_value do |i|
			@concepts.each_value do |j|
				if (i.id!=j.id) then
					i.try_adding_neighbor j
				end
			end
		end
	end	
	
	def show_data
		lMode=@param[:show_mode]
		verbose "[INFO] Showing concept data..."
		if lMode==:resume then
			s="* Concepts ("+@concepts.count.to_s+"): "
			@concepts.each_value { |c| s=s+c.name+", " }
			verbose s
		elsif lMode==:default then
			@concepts.each_value do |c| 
				verbose c.to_s if c.process?
			end
		end
	end
	
	def show_stats
		return if @param[:show_mode]==:none
		puts "[INFO] Showing concept stats..."
		total_q=0 
		total_e=0
		total_c=0
		@concepts.each_value do |c|
			if c.process?
				e=c.data[:texts].size
				c.data[:tables].each { |t| e=e+t.data[:fields].size*t.data[:rows].size }
				puts "* Concept: name=#{c.name} "+"-"*(30-c.name.size).abs+"(Q=#{c.num.to_s}, E=#{e.to_s}, %=#{(c.num/e*100).to_i})"
				total_q+=c.num
				total_e+=e
				total_c+=1
			end
		end
		puts "* TOTAL(#{total_c.to_s}) "+"-"*35+"(Q=#{total_q.to_s}, E=#{total_e.to_s}, %=#{(total_q/total_e*100).to_i})"
	end
	
	def create_output_file
		verbose "\n[INFO] Creating output files..."

		lFile=File.new(@outputname,'w')
		lFile.write("// File: #{@outputname}\n")
		lFile.write("// Time: "+Time.new.to_s+"\n")
		lFile.write("// Create automatically by David Vargas\n")
		lFile.write("\n")
		lFile.write("$CATEGORY: $course$/#{@param[:category].to_s}\n") if @param[:category]!=:none
		@concepts.each_value do |c| 
			c.write_questions_to(lFile) if c.process?
		end
		lFile.close
		
		if @param[:lesson_file]!=:none then
			lFile=File.new(@param[:outputdir]+'/'+@param[:lesson_file],'w')
			@concepts.each_value do |c| 
				c.write_lesson_to(lFile) if c.process?
			end
			lFile.close
		end
		
		@logfile.close
	end

	def init_config_file(pFilename='default')
		init
		
		tags=[ :inputdirs, :lesson_file, :logname, :outputname, :process_file ]		
		tags.each { |t| @param[t]=@param[t].gsub('default',pFilename) }

		puts YAML::dump(@param)
	end
	
private	

	def verbose(lsText)
		if @verbose then
			puts lsText
			@logfile.write(lsText.to_s+"\n")
		end
	end
end	
