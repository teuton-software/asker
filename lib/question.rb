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
    pFile.write self.to_gift
  end

  def to_gift
    # Return question using gift format
    s="// #{@comment}\n" if !@comment.nil?
    s << "::#{@name}::[html]#{satanize(@text)}\n"

    case @type
    when :choice
      s << "{\n"
      s << "  =#{@good}\n"
      @bads.each { |i| s << "  ~#{satanize(i)}\n" }
      s <<  "}\n\n"
	when :boolean
      s << "{#{@good}}\n\n"
    when :match
      s << "{\n"
      @matching.each { |i| s << "  =#{satanize(i[0])} -> #{satanize(i[1])}\n" }
      s << "}\n\n"
    when :short
      s << "{\n"
      @shorts.each { |i| s << "  =%100%#{i}#\n" }
      s << "}\n\n"
    end
    return s
  end
	
  def to_s
    s=""
    s=s+"// #{satanize(@comment)}\n" if !@comment.nil?
    s=s+"::#{@name}::[html]#{satanize(@text)}\n"
		
    case @type
    when choice
      s=s+"{\n"
      s=s+"  =#{satanize(@good)}\n"
      @bads.each { |i| s=s+"  ~#{satanize(i)}\n" }
      s=s+"}\n\n"
    when :boolean
      s=s+"{#{@good}}\n\n"
    when :match
      s=s+"{\n"
      @matching.each { |i| s=s+"  =#{satanize(i[0])} -> #{satanize(i[1])}\n" }
      s=s+"}\n\n"
    when :short
      s=s+"{"
      @shorts.each { |i| s=s+"=%100%#{satanize(i)} " }
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

  def satanize(psText)
    lsText=psText.sub("\n", " ")
    lsText.sub!(":","\:")
    lsText.sub!("=","\=")
    return lsText
  end
	
end
