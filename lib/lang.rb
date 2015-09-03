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

		filename=File.join(dirbase, "locales", "#{lang}-templates.yaml" )
		@templates=YAML::load(File.new(filename))

		filename=File.join( dirbase, "locales", "#{lang}-connectors.yaml" )
		@connectors=YAML::load(File.new(filename))
	end
	
	def text_for(pOption, pText1="", pText2="", pText3="", pText4="", pText5="")
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
		input_lines=pText.split(".")
		output_lines=[]
		output_words=[]
		input_lines.each_with_index do |line, rowindex| 
			row=[]
			line.split(" ").each_with_index do |word,colindex|
			  flag=@connectors.include? word.downcase
			  
				if (flag and pFilter) or (!flag and !pFilter) then
					output_words<< {:word => word, :row => rowindex, :col => colindex }
					row << (output_words.size-1)
				else
					row << word
				end
			end
			row << "."
			output_lines << row
		end		
		result={}
		result[:lines]=output_lines
		result[:words]=output_words
		return result
	end

	def text_with_connectors(pText)
		return text_filter_connectors(pText, false)
	end

	def text_without_connectors(pText)
		return text_filter_connectors(pText, true)
	end
	
	def build_text_from_filtered( pStruct, pIndexes)
		lines = pStruct[:lines]
				
		lText=""
		lines.each do |line|
			line.each do |value|
				if value.class==String
					lText+=" "+value 
				elsif value.class==Fixnum
					if pIndexes.include? value then
						lText+=" [#{value.to_s}]"
					else	
						lrow = pStruct[:words][value][:row]
						lcol = pStruct[:words][value][:col]
						lword = pStruct[:words][value][:word]
						lText+=" "+lword
					end
				end
			end
		end
		return lText
	end
	
end
