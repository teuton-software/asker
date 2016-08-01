# encoding: utf-8

class QuestionGiftFormatter

  def initialize(question)
    @question = question
  end

  def to_s
    # Return question using gift format
    s="// #{@question.comment}\n" if not ( @question.comment.nil? and @question.comment.empty? )
    s << "::#{@question.name}::[html]#{sanitize(@question.text)}\n"

    case @question.type
    when :choice
      s=s+"{\n"
      a=["  =#{sanitize(@question.good)}\n"]
      penalties = [ '', '%-50%','%-33%','%-25%','%-20%']
      penalty = penalties[@question.bads.size]

      @question.bads.each { |i| a << ("  ~#{penalty}" + sanitize(i)+"\n") }
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
      s << "{#{@question.good}}\n\n"
    when :match
      s << "{\n"
      a=[]
      @question.matching.each do |i,j|
        i=i[0,220]+"...(ERROR: text too long)" if i.size>255
        j=j[0,220]+"...(ERROR: text too long)" if j.size>255
        a << "  =#{sanitize(i)} -> #{sanitize(j)}\n"
      end
      a.shuffle!
      a.each { |i| s << i }
      s << "}\n\n"
    when :short
      s << "{\n"
      @question.shorts.uniq!
      @question.shorts.each do |i|
        text=i
        text=i[0,220]+"...(ERROR: too long)" if text.size>255
        s << "  =%100%#{text}#\n"
      end

      s << "}\n\n"
    end
    return s
  end

private

  def sanitize(psText="")
    lsText=psText.sub("\n", " ")
    lsText.sub!(":","\:")
    lsText.sub!("=","\\=")
    return lsText
  end

end
