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
      @bads.each { |i| a << ('  ~%-25%'+sanitize(i)+"\n") }
      a.shuffle!
      a.each do |i| 
        text=i
        if text.size>255
          text=i[0,220]+"...(ERROR: text too long)"
        end
        s << text 
      end
      s=s+"}\n\n"
	when :boolean
      s << "{#{@good}}\n\n"
    when :match
      s << "{\n"
      a=[]
      @matching.each do |i|
        i[0]=i[0][0,220]+"...(ERROR: too long)" if i[0].size>255
        i[1]=i[1][0,220]+"...(ERROR: too long)" if i[1].size>255
        a << "  =#{sanitize(i[0])} -> #{sanitize(i[1])}\n" 
      end
      a.shuffle!
      a.each { |i| s << i }
      s << "}\n\n"
    when :short
      s << "{\n"
      @shorts.each do |i|
        text=i
        text=i[0,220]+"...(ERROR: too long)" if text.size>255
        s << "  =%100%#{text}#\n"
      end
      
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
      @bads.each { |i| a << ('  ~%-25%'+sanitize(i)+"\n") }
      a.shuffle!
      a.each do |i| 
        text=i
        text=i[0,220]+"...(ERROR: too long)" if text.size>255
        s << text
      end
      s=s+"}\n\n"
    when :boolean
      s=s+"{#{@good}}\n\n"
    when :match
      s=s+"{\n"
      @matching.each do |i|
        i[0]=i[0][0,220]+"...(ERROR: too long)" if i[0].size>255
        i[1]=i[1][0,220]+"...(ERROR: too long)" if i[1].size>255
        a << "  =#{sanitize(i[0])} -> #{sanitize(i[1])}\n" 
      end
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
