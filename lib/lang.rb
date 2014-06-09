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

		filename=File.join(dirbase, "lang", "#{lang}-templates.yaml" )
		@templates=YAML::load(File.new(filename))

		filename=File.join( dirbase, "lang", "#{lang}-connectors.yaml" )
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
		hidden_words=[]
		raw_lines.each do |line| 
			row=[]
			line.split(" ").each do |word|
			  flag=@connectors.include? word.downcase
			  
				if (flag and pFilter) or (!flag and !pFilter) then
					hidden_words<<word
					row << (hidden_words.size-1)
				else
					row << word
				end
			end
			lines << row
		end		
		result={}
		result[:lines]=lines
		result[:hidden_words]=hidden_words
		return result
	end

	def text_with_connectors(pText)
		return text_filter_connectors(pText, false)
	end

	def text_without_connectors(pText)
		return text_filter_connectors(pText, true)
	end
	
	def simplify_filteredtext( pFilteredText, pMax)
		lines=pFilteredText[:lines]
		hidden_words=pFilteredText[:hidden_words]
		
		while hidden_words.size>pMax
			number=rand(hidden_words.size)

			lines.each do |line|
				j=line.index(number)
				line[j]=hidden_words[number] if !j.nil?
			end
			
			lines.each do |line|
				(number..hidden_words.size).to_a.each do |i|
					if line[i].class==Numeric and line[i]>number
						line[i]-=1
					end
				end
			end

			hidden_words.delete_at(number)
			
		end

		result={}
		result[:lines]=lines
		result[:hidden_words]=hidden_words
		return result
	end
	
end
