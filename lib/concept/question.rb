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
    s << "::#{@name}::[html]#{sanitize(@text)}\n"

    case @type
    when :choice
      s=s+"{\n"
      a=["  =#{sanitize(@good)}\n"]
      @bads.each { |i| a << "  ~#{sanitize(i)}\n" }
      a.shuffle!
      a.each { |i| s << i }
      s=s+"}\n\n"
	when :boolean
      s << "{#{@good}}\n\n"
    when :match
      s << "{\n"
      a=[]
      @matching.each { |i| a << "  =#{sanitize(i[0])} -> #{sanitize(i[1])}\n" }
      a.shuffle!
      a.each { |i| s << i }      
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
    s=s+"// #{sanitize(@comment)}\n" if !@comment.nil?
    s=s+"::#{@name}::[html]#{sanitize(@text)}\n"
		
    case @type
    when :choice
      s=s+"{\n"
      a=["  =#{sanitize(@good)}\n"]
      @bads.each { |i| a << "  ~#{sanitize(i)}\n" }
      a.shuffle!
      a.each { |i| s << i }
      s=s+"}\n\n"
    when :boolean
      s=s+"{#{@good}}\n\n"
    when :match
      s=s+"{\n"
      @matching.each { |i| s=s+"  =#{sanitize(i[0])} -> #{sanitize(i[1])}\n" }
      s=s+"}\n\n"
    when :short
      s=s+"{"
      @shorts.each { |i| s=s+"=%100%#{sanitize(i)} " }
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

  def sanitize(psText="")
    lsText=psText.sub("\n", " ")
    lsText.sub!(":","\:")
    lsText.sub!("=","\\=")
    return lsText
  end
	
end
