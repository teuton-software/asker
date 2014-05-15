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
		filename="#{dirbase}/lang/#{lang}.yaml"

		@templates=YAML::load(File.new(filename))
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
end
