#!/usr/bin/ruby
# encoding: utf-8

class Question
	attr_accessor :name, :comment, :text
	attr_accessor :good, :bads, :matching, :shorts
	attr_reader :type

	def initialize
		init
	end
	
	def init
		@name=""
		@comment=""
		@text=""
		@type=:choice
		@good=""
		@bads=[]
		@matching=[]
		@shorts=[]
	end
		
	def write_to_file(pFile)
		pFile.write "// #{@comment}\n" if !@comment.nil?
		pFile.write "::#{@name}::[html]#{replace(@text)}\n"
		
		if @type==:choice then
			pFile.write "{\n"
			pFile.write "  =#{@good}\n"
			@bads.each { |i| pFile.write "  ~#{replace(i)}\n" }
			pFile.write "}\n\n"
		elsif @type==:boolean then
			pFile.write "{#{@good}}\n\n"
		elsif @type==:match then
			pFile.write "{\n"
			@matching.each { |i| pFile.write "  =#{replace(i[0])} -> #{replace(i[1])}\n" }
			pFile.write "}\n\n"
		elsif @type==:short then
			pFile.write "{"
			@shorts.each { |i| pFile.write "=%100%#{i} " }
			pFile.write "}\n\n"
		end
	end
	
	def to_s
		s=""
		s=s+"// #{@comment}\n" if !@comment.nil?
		s=s+"::#{@name}::[html]#{@text}\n"
		
		if @type==:choice then
			s=s+"{\n"
			s=s+"  =#{@good}\n"
			@bads.each { |i| s=s+"  ~#{i}\n" }
			s=s+"}\n\n"
		elsif @type==:boolean then
			s=s+"{#{@good}}\n\n"
		elsif @type==:match then
			s=s+"{\n"
			@matching.each { |i| s=s+"  =#{i[0]} -> #{i[1]}\n" }
			s=s+"}\n\n"
		elsif @type==:short then
			s=s+"{"
			@shorts.each { |i| s=s+"=%100%#{i} " }
			s=s+"}\n\n"
		end
		return s
	end
	
	def set_choice
		@type=:choice
	end
	
	def set_match
		@type=:match
	end

	def set_boolean
		@type=:boolean
	end
	
	def set_short
		@type=:short
	end

	def reset
		init
	end
	
private

	def replace(psText)
		lsText=psText.sub("\n", " ")
		lsText.sub!(":","\:")
		lsText.sub!("=","\=")
		return lsText
	end
	
end
