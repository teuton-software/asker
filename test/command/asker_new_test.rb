require "test/unit"
require "fileutils"

class AskerNewTest < Test::Unit::TestCase
  def test_new
    dir = "delete.this.new"
    cmd = "./asker new #{dir} > /dev/null"
    assert_equal true,  system(cmd)

    filename = File.join(dir, "example-concept.haml")
    assert_equal true, File.exist?(filename)
    FileUtils.rm(filename)
    assert_equal false,  File.exist?(filename)

    assert_equal true, Dir.exist?(dir)
    FileUtils.rmdir(dir)
    assert_equal false,  Dir.exist?(dir)
  end

  def test_new_then_file
    dir = "delete.this.file"
    cmd = "./asker new #{dir} > /dev/null"
    assert_equal true,  system(cmd)

    filename = File.join(dir, 'example-concept.haml')
    cmd = "./asker file #{filename} > /dev/null"
    assert_equal true,  system(cmd)
    cmd = "./asker #{filename} > /dev/null"
    assert_equal true,  system(cmd)

    assert_equal true, File.exist?(filename)
    assert_equal true,  system("rm #{filename}")
    assert_equal true,  system("rmdir #{dir}")
  end
end
