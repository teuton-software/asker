require "test/unit"
require_relative "../../lib/asker/loader/embedded_file/loader"

class EmbeddedFileLoaderTest < Test::Unit::TestCase
  def setup
    @localdir = File.join(File.dirname(__FILE__), "..", "input")
  end

  def test_load_local_audio
    value = File.join("files", "aifa.mp3")
    data = EmbeddedFile::Loader.new.call(value, @localdir)

    assert_equal 3, data.size
    text = "<audio controls><source src=\"@@PLUGINFILE@@/aifa.mp3\">Your browser does not support the audio tag.</audio>"
    assert_equal text, data[:text]
    assert_equal get_encode(value, @localdir), data[:file]
    assert_equal :audio, data[:type]
  end

  def test_load_local_image
    value = File.join('files', 'john-lennon.png')
    data = EmbeddedFile::Loader.new.call(value, @localdir)

    assert_equal 3, data.size
    text = "<img src=\"@@PLUGINFILE@@/john-lennon.png\" alt=\"imagen\" class=\"img-responsive atto_image_button_text-bottom\">"
    assert_equal text, data[:text]
    assert_equal get_encode(value, @localdir), data[:file]
    assert_equal :image, data[:type]
  end

  def test_load_remote_image
    value = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/John_Lennon_1969_%28cropped%29-Colorized.jpg/800px-John_Lennon_1969_%28cropped%29-Colorized.jpg"
    data = EmbeddedFile::Loader.new.call(value, @localdir)

    assert_equal 3, data.size
    text = "<img src=\"#{value}\" alt=\"image\" width=\"400\" height=\"300\">"
    assert_equal text, data[:text]
    assert_equal :none, data[:file]
    assert_equal :url, data[:type]
  end

  def test_load_local_text
    value = File.join('files', 'quote.txt')
    data = EmbeddedFile::Loader.new.call(value, @localdir)

    assert_equal 3, data.size
    text = "<pre>Life is what happens when you're busy making other plans.\n" \
           + "(Author?)\n</pre>"
    assert_equal text, data[:text]
    assert_equal :none, data[:file]
    assert_equal :text, data[:type]
  end

  def get_encode(value, localdir)
    filepath = File.join(localdir, value)
    encode = '<file name="' + File.basename(filepath) \
                    + '" path="/" encoding="base64">' \
                    + Base64.strict_encode64(File.open(filepath, 'rb').read) + '</file>'
    encode
  end
end
