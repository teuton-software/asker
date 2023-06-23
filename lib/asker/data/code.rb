# frozen_string_literal: true

require_relative "../ai/code/code_ai_factory"
require_relative "../logger"

class Code
  attr_reader :dirname, :filename, :type
  attr_accessor :process, :features
  attr_reader :lines, :questions

  def initialize(dirname, filename, type)
    @dirname = dirname
    @filename = filename
    @type = type
    @filepath = File.join(@dirname, @filename)
    @process = false
    @features = []
    @lines = load(@filepath)
    @questions = []
  end

  def process?
    @process
  end

  def lines_to_s(lines)
    out = ""
    lines.each_with_index do |line, index|
      out << format("%2d| #{line}\n", (index + 1))
    end
    out
  end

  private

  def load(filepath)
    return if filepath.nil?

    unless File.exist? filepath
      Logger.warn "Code: Unknown file (#{filepath})"
      return
    end
    content = File.read(filepath)
    encode_and_split(content)
  end

  def encode_and_split(text, encoding = :default)
    # Convert text to UTF-8 deleting unknown chars
    text ||= "" # Ensure text is not nil
    flag = [:default, "UTF-8"].include? encoding
    return text.encode("UTF-8", invalid: :replace).split("\n") if flag

    # Convert text from input ENCODING to UTF-8
    ec = Encoding::Converter.new(encoding.to_s, "UTF-8")
    begin
      text = ec.convert(text)
    rescue => e
      Logger.warn "Code: Encoding error (#{e}) with filename (#{@filename})"
    end

    text.split("\n")
  end
end
