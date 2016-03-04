# encoding: utf-8


require 'singleton'

class Learn
  include Singleton
  
  attr_accessor :data
  
  def initialize
    @data={}
    @lang="es"
    @filename=File.join("lib","concept","lang","locales",@lang,"undefs.yaml")
    load_data
  end
  
  def language(pLang)
    return if pLang==@lang
    save
    @lang=pLang
    @filename=File.join("lib","concept","lang","locales",@lang,"undefs.yaml")
    load
  end
  
  def load_data
    @data =YAML::load(File.open(@filename))
  end
  
  def save
    return if @filename.nil?
    File.open(@filename, 'w') {|f| f.write @data.to_yaml } 
  end
  
  def learn_word(pWord)
    puts pWord, @data
    return if !@data[pWord.to_sym].nil?
    puts "La palabra #{Rainbow(pWord).green} es (s=Sujeto, v=Verbo, a=Adjetivo, d=Adverbio) [s/v/a/d]? "
    op = gets.chop
    @data[pWord.to_sym]=op
  end

  def learn_text(text)
    words=text.split(" ")
    words.each { |word| learn_word word.downcase }
  end
  
end
