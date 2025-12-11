require "test/unit"

class ExamplesTest < Test::Unit::TestCase
  def setup
    @filepaths = Dir.glob(File.join("docs", "examples", "**", "*haml"))
  end

  def test_asker_check_examples
    @filepaths.each do |filepath|
      assert_equal true, system("./asker check #{filepath} 2>&1 > /dev/null")
    end
  end

  def test_asker_file_examples
    @filepaths.each do |filepath|
      assert_equal true, system("./asker file #{filepath} >/dev/null")
    end
  end
end
