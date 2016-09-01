#!/usr/bin/ruby

require "minitest/autorun"
require 'rexml/document'
require 'pry'

require_relative "../../lib/data/data_field"

class DataFieldTest < Minitest::Test

  def test_data_0
    d = DataField.new("obiwan", 0, "text")

    assert_equal "obiwan", d.get(:raw)
    assert_equal "obiwan", d.get(:decorated)
    assert_equal "obiwan", d.get(:id)
    assert_equal "obiwan", d.get(:screen)
  end

  def test_data_1
    url = "http://www1/url/to/textfile.rb"
    d = DataField.new(url, 1, "textfile_url")

    assert_equal url                                  , d.get(:raw)
    assert_equal "<a href=\"#{url}\">Textfile URL</a>", d.get(:decorated)
    assert_equal "textfile_url.1"                     , d.get(:id)
    assert_equal "http://.../to/textfile.rb"          , d.get(:screen)
  end

  def test_data_2
    url = "http://www2/url/to/image.png"
    d = DataField.new( url, 2, "image_url")

    assert_equal url                                 , d.get(:raw)
    assert_equal "<img src=\"#{url}\" alt=\"image\">", d.get(:decorated)
    assert_equal "image_url.2"                       , d.get(:id)
    assert_equal "http://...rl/to/image.png"             , d.get(:screen)
  end

  def test_data_3
    longname = "this-is-just-a-very-0123456789-very-long-name"
    d = DataField.new(longname, 0, "text")

    assert_equal longname, d.get(:raw)
    assert_equal longname, d.get(:decorated)
    assert_equal longname, d.get(:id)
    assert_equal "this-is...-very-long-name", d.get(:screen)
  end

end
