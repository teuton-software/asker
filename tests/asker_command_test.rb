#!/usr/bin/ruby

require 'test/unit'

class AskerCommandTest < Test::Unit::TestCase

  def test_version
    assert_equal true,  system('asker version > /dev/null')
  end

  def test_file_argument
    filename = File.join('docs', 'examples', 'bands', 'acdc.haml')
    cmd = "asker file #{filename} > /dev/null"
    assert_equal true,  system(cmd)

    cmd = "asker #{filename} > /dev/null"
    assert_equal true,  system(cmd)
  end

  def test_init
    cmd = "asker init > /dev/null"
    assert_equal true,  system(cmd)

    filename = 'asker.ini'
    assert_equal true, File.exist?(filename)
    assert_equal true,  system("rm #{filename}")
  end

  def test_new
    dir = 'delete.this.new'
    cmd = "asker new #{dir} > /dev/null"
    assert_equal true,  system(cmd)

    filename = File.join(dir, 'example-concept.haml')
    assert_equal true, File.exist?(filename)
    assert_equal true,  system("rm #{filename}")
    assert_equal true,  system("rmdir #{dir}")
  end

  def test_check
    dir = 'delete.this.check'
    cmd = "asker new #{dir} > /dev/null"
    assert_equal true,  system(cmd)

    filename = File.join(dir, 'example-concept.haml')
    cmd = "asker check #{filename} > /dev/null"
    assert_equal true,  system(cmd)

    assert_equal true, File.exist?(filename)
    assert_equal true,  system("rm #{filename}")
    assert_equal true,  system("rmdir #{dir}")
  end

  def test_new_then_file
    dir = 'delete.this.file'
    cmd = "asker new #{dir} > /dev/null"
    assert_equal true,  system(cmd)

    filename = File.join(dir, 'example-concept.haml')
    cmd = "asker file #{filename} > /dev/null"
    assert_equal true,  system(cmd)
    cmd = "asker #{filename} > /dev/null"
    assert_equal true,  system(cmd)

    assert_equal true, File.exist?(filename)
    assert_equal true,  system("rm #{filename}")
    assert_equal true,  system("rmdir #{dir}")
  end

  def test_check_example_band
    filename = File.join('docs', 'examples', 'band', 'acdc.haml')
    cmd = "asker check #{filename} > /dev/null"
    assert_equal true,  system(cmd)
  end

  def test_check_example_code
    filename = File.join('docs', 'examples', 'code', 'python.haml')
    cmd = "asker check #{filename} > /dev/null"
    assert_equal true,  system(cmd)
  end

  def test_check_example_home
    filename = File.join('docs', 'examples', 'home', 'furniture.haml')
    cmd = "asker check #{filename} > /dev/null"
    assert_equal true,  system(cmd)

    filename = File.join('docs', 'examples', 'home', 'xml', 'furniture.haml')
    cmd = "asker check #{filename} > /dev/null"
    assert_equal true,  system(cmd)
  end

  def test_check_example_loading_files
    filename = File.join('docs', 'examples', 'loading_files', 'john-lennon.haml')
    cmd = "asker check #{filename} > /dev/null"
    assert_equal true,  system(cmd)
  end

  def test_check_example_starwars
    filename = File.join('docs', 'examples', 'starwars', 'jedi.haml')
    cmd = "asker check #{filename} > /dev/null"
    assert_equal true,  system(cmd)

    filename = File.join('docs', 'examples', 'starwars', 'sith.haml')
    cmd = "asker check #{filename} > /dev/null"
    assert_equal true,  system(cmd)
  end
end
