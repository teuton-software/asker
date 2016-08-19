# encoding: utf-8

require "base64_compatible"
require_relative 'base_stage'
require_relative '../question'

class StageI < BaseStage
  #range i1, i2, i3

  def run
    #Stage I: process every image from <def> tag
    questions=[]

    #for every <image> do this
    images.each do |url|
      s=Set.new [name, lang.text_for(:none)]
      neighbors.each { |n| s.add n[:concept].name }
      a=s.to_a

      #Question type <f1>: choose between 4 options
      if s.count>3 then
        q=Question.new(:choice)
        q.name="#{name}-#{num}-i1choose"
        q.text=lang.text_for(:i1, url )
        q.good=name
        q.bads << lang.text_for(:none)
        q.bads << a[2]
        q.bads << a[3]
        questions << q
      end

      #Question type <i1>: choose between 4 options, good none (Syntax error)
      if s.count>3 then
        q=Question.new(:choice)
        q.name="#{name}-#{num}-i1misspelling"
        q.text=lang.text_for(:i1, url )
        q.good = lang.text_for(:none)
        q.bads << lang.do_mistake_to(name)
        q.bads << a[2]
        q.bads << a[3]
        questions << q
      end

      s.delete(name)
      a=s.to_a

      #Question type <i1>: choose between 4 options, good none
      if s.count>3 then
        q = Question.new(:choice)
        q.name="#{name}-#{num}-i1none"
        q.text=lang.text_for(:i1, url )
        q.good=lang.text_for(:none)
        q.bads << a[1]
        q.bads << a[2]
        q.bads << a[3]
        questions << q
      end

      #Question type <f2>: boolean => TRUE
      q = Question.new(:boolean)
      q.name="#{name}-#{num}-i2true"
      q.text=lang.text_for(:i2, url, name )
      q.good="TRUE"
      questions << q

      #Question type <i2>: boolean => FALSE
      if neighbors.count>0 then
        q = Question.new(:boolean)
        q.name="#{name}-#{num}-i2false"
        q.text=lang.text_for(:i2, url, neighbors[0][:concept].name )
        q.good="FALSE"
        questions << q
      end

      #Question type <i3>: hidden name questions
      q = Question.new(:short)
      q.name="#{name}-#{num}-i3short"
      q.text=lang.text_for(:i3, url, lang.hide_text(name) )
      q.shorts << name
      q.shorts << name.gsub("-"," ").gsub("_"," ")
      questions << q
      return questions
    end
  end

private

  def html_for_raw_image(filename)
    dirname = File.dirname(@concept_ia.filename)
    filepath = File.join(dirname,filename)
    content = File.open(filepath).read
    content64 = Base64Compatible.encode64( content )
    output =""
    until(content64.nil?) do
      output = output + content64[0,76]+"\n"
      tmp = content64[76,9999999]
      content64 = tmp
    end

    ext =  File.extname(filename)
    output = "<img src='data:image/#{ext};base64,#{output}' />"
    return output
  end

end
