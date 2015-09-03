# encoding: utf-8

=begin
require 'erb'
require 'yaml'

module LANG

	def self.configure
		@templates=YAML::load(File.new('lib/lang/config.yaml'))
	end
	
	def self.text(pLang, pOption, pText1, pText2="")
		templates={}
		lText1=pText1
		lText2=pText2
		
		if pOption=='a1-desc' then
			templates['es']="Definición\: \"<%=lText1%>\"<br/>Elige la opción que mejor se corresponda con la definición anterior.<br/>"
			templates['en']="Definition\: \"<%=lText1%>\"<br/>Choose the best association for the previous definition.<br/>"
		elsif pOption=='a2-desc' then
			templates['es']="Definición\: \"<%=lText1%>\"<br/>Elige la opción que mejor se corresponda con la definición anterior.<br/>"
			templates['en']="Definition\: \"<%=lText1%>\"<br/>Choose the best association for the previous definition.<br/>"
		elsif pOption=='a3-desc' then
			templates['es']="Definición de #{lText1}\:<br/> \"#{lText2}\"<br/>"
			templates['en']="Definition of #{lText1}\:<br/> \"#{lText2}\"<br/>"
		elsif pOption=='a4-desc' then
			templates['es']="Definición de #{lText1}\:<br/> \"#{lText2}\"<br/>"
			templates['en']="Definition of #{lText1}\:<br/> \"#{lText2}\"<br/>"
		end
		
		renderer = ERB.new(templates[pLang])
		output = renderer.result(binding)
		return output
	end
end
=end
