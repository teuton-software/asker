require "test/unit"
require "fileutils"

class AskerCheckTest < Test::Unit::TestCase
  def test_check
    dir = "delete.this.check"
    cmd = "asker new #{dir} > /dev/null"
    assert_equal true,  system(cmd)

    filename = File.join(dir, 'example-concept.haml')
    cmd = "asker check #{filename} 2>&1 > /dev/null"
    assert_equal true,  system(cmd)

    assert_equal true, File.exist?(filename)
    FileUtils.rm(filename)
    assert_equal false,  File.exist?(filename)

    assert_equal true, Dir.exist?(dir)
    FileUtils.rmdir(dir)
    assert_equal false,  Dir.exist?(dir)
  end

  def test_check_example_band
    filename = File.join("docs", "examples", "bands", "acdc.haml")
    cmd = "asker check #{filename} > /dev/null"
    assert_equal true, system(cmd)
  end

  def test_check_example_code
    filename = File.join("docs", "examples", "code", "python.haml")
    cmd = "asker check #{filename} > /dev/null"
    assert_equal true,  system(cmd)
  end

  def test_check_example_home_ok
    filename = File.join("docs", "examples", "home", "furniture.haml")
    cmd = "asker check #{filename} > /dev/null"
    assert_equal true,  system(cmd)
  end

  def test_check_example_home_fail
    filename = File.join("docs", "examples", "home", "xml", "furniture.xml")
    cmd = "asker check #{filename} 2> /dev/null"
    assert_equal false,  system(cmd)
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
