# encoding: utf-8

require 'erb'
require 'yaml'

module LANG

	def self.configure
		@templates=YAML::load(File.new('lib/lang/config.yaml'))
	end
	
	def self.text(pOption, pText, pLang='es')
		templates={}
		lText=pText
		if pOption=='a1-desc' then
			templates['es']="Definición\: \"<%=lText%>\"<br/>Elige la opción que mejor se corresponda con la definición anterior.<br/>"
			templates['en']="Definition\: \"<%=lText%>\"<br/>Choose the best association for the previous definition.<br/>"
		elsif pOption=='a2-desc' then
			templates['es']="Definición\: \"<%=lText%>\"<br/>Elige la opción que mejor se corresponda con la definición anterior.<br/>"
			templates['en']="Definition\: \"<%=lText%>\"<br/>Choose the best association for the previous definition.<br/>"
		end
		renderer = ERB.new(templates[pLang])
		output = renderer.result(binding)
		return output
	end
end
