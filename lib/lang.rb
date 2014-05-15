# encoding: utf-8

require 'erb'
require 'yaml'

class Lang
	attr_accessor :lang

	def initialize(lang='en')
		@lang=lang

		d=(__FILE__).split("/")
		d.delete_at(-1)
		dirbase=d.join("/")

		filename="#{dirbase}/lang/#{lang}-templates.yaml"
		@templates=YAML::load(File.new(filename))

		filename="#{dirbase}/lang/#{lang}-connectors.yaml"
		@connectors=YAML::load(File.new(filename))
	end
	
	def text_for(pOption, pText1, pText2="", pText3="", pText4="", pText5="")
		text1=pText1
		text2=pText2
		text3=pText3
		text4=pText4
		text5=pText5
		
		renderer = ERB.new(@templates[pOption])
		output = renderer.result(binding)
		return output
	end
	
	def text_filter_connectors(pText, pFilter)
		raw_lines=pText.split(".")
		lines=[]
		hiden_words=[]
		raw_lines.each do |line| 
			row=[]
			line.split(" ").each do |word|
			  flag=@connectors.include? word.downcase
			  
				if (flag and pFilter) or (!flag and !pFilter) then
					row << "*"*word.size
					hiden_words<<word
				else
					row << word
				end
			end
			lines << row
		end
		lines.each do |line| puts line.to_s+"." end
		puts hiden_words.join(',')
	end

	def text_with_connectors(pText)
		return text_filter_connectors(pText, false)
	end

	def text_without_connectors(pText)
		return text_filter_connectors(pText, true)
	end
	
end
