require "test/unit"
require "fileutils"

class AskerInitTest < Test::Unit::TestCase
  def test_init
    filename = 'asker.ini'
    assert_equal false, File.exist?(filename)

    cmd = "./asker init > /dev/null"
    assert_equal true, system(cmd)

    assert_equal true, File.exist?(filename)
    FileUtils.rm(filename)
    assert_equal false, File.exist?(filename)
  end
end
