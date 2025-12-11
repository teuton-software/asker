require "test/unit"
require "fileutils"

class AskerFileTest < Test::Unit::TestCase
  def test_file_argument
    filename = File.join("docs", "examples", "bands", "acdc.haml")
    cmd = "./asker file #{filename} > /dev/null"
    assert_equal true,  system(cmd)

    cmd = "./asker #{filename} > /dev/null"
    assert_equal true,  system(cmd)
  end
end
