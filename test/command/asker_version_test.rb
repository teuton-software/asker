require "test/unit"
require "fileutils"

class AskerVersionTest < Test::Unit::TestCase
  def test_version
    assert_equal true, system("asker version > /dev/null")
  end
end
