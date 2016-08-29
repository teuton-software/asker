#!/usr/bin/ruby

require "minitest/autorun"
require 'rexml/document'
require 'pry'

require_relative "../../lib/data/data_field"

class DataFieldTest < Minitest::Test
  def setup
    @data = []
    @data[0] = DataField.new("obiwan", 0, "text")
    @data[1] = DataField.new("http://www1/url/to/textfile.rb", 1, "textfile_url")
    @data[2] = DataField.new("http://www2/url/to/image.png"  , 2, "image_url")
  end

  def test_data_0
    d = @data[0]
    assert_equal "obiwan", d.get(:raw)
    assert_equal "obiwan", d.get(:decorated)
    assert_equal "obiwan", d.get(:id)
  end

  def test_data_1
    d = @data[1]
    url = "http://www1/url/to/textfile.rb"
    assert_equal url                                , d.get(:raw)
    assert_equal "<a href=\"#{url}\">textfile_url</a>", d.get(:decorated)
    assert_equal "textfile_url.1"                   , d.get(:id)
  end

  def test_data_2
    d = @data[2]
    url = "http://www2/url/to/image.png"
    assert_equal url                                 , d.get(:raw)
    assert_equal "<img src=\"#{url}\" alt=\"image\">", d.get(:decorated)
    assert_equal "image_url.2"                       , d.get(:id)
  end
end
