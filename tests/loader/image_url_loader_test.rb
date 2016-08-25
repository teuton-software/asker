#!/usr/bin/ruby

require 'minitest/autorun'
require 'pry'
require_relative "../../lib/loader/image_url_loader"

class ImageUrlLoaderTest < Minitest::Test

  def setup
    @filters  = [ 'obiwan', 'yoda', ['character', 'starwars'] ]
  end

  def test_load
    @filters.each do |filter|
      urls = ImageUrlLoader::load(filter)
      assert_equal Array, urls.class
      assert_equal 20,    urls.size
    end
  end
end
