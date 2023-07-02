require "test/unit"
require "rexml/document"
require_relative "../../lib/asker/data/data_field"

class DataFieldTest < Test::Unit::TestCase
  def test_text_data
    d = DataField.new('obiwan', 0, 'text')

    assert_equal 0,        d.id
    assert_equal :text,    d.type
    assert_equal 'obiwan', d.get(:raw)
    assert_equal 'obiwan', d.get(:decorated)
    assert_equal 'obiwan', d.get(:id)
    assert_equal 'obiwan', d.get(:screen)
  end

  def test_textfile_url_data
    url = 'http://www1/url/to/textfile.rb'
    d = DataField.new(url, 1, 'textfile_url')

    assert_equal 1,                                     d.id
    assert_equal :textfile_url,                         d.type
    assert_equal url,                                   d.get(:raw)
    assert_equal "<a href=\"#{url}\">Textfile URL</a>", d.get(:decorated)
    assert_equal 'textfile_url.1',                      d.get(:id)
    assert_equal 'http://.../to/textfile.rb',           d.get(:screen)
  end

  def test_image_url_data
    url = 'http://www2/url/to/image.png'
    d = DataField.new(url, 2, 'image_url')

    assert_equal 2,                                    d.id
    assert_equal :image_url,                           d.type
    assert_equal url,                                  d.get(:raw)
    assert_equal "<img src=\"#{url}\" alt=\"image\">", d.get(:decorated)
    assert_equal 'image_url.2',                        d.get(:id)
    assert_equal 'http://...rl/to/image.png',          d.get(:screen)
  end

  def test_long_text_data
    longname = 'this-is-just-a-very-0123456789-very-long-name'
    d = DataField.new(longname, 3, 'text')

    assert_equal 3,                           d.id
    assert_equal :text,                       d.type
    assert_equal longname,                    d.get(:raw)
    assert_equal longname,                    d.get(:decorated)
    assert_equal longname,                    d.get(:id)
    assert_equal 'this-is...-very-long-name', d.get(:screen)
  end

  def test_textfile_path
    filepath = File.join('test', 'input', 'files', 'hosts')
    d = DataField.new(filepath, 4, 'textfile_path')

    assert_equal 4,                           d.id
    assert_equal :textfile_path,              d.type
    assert_equal filepath,                    d.get(:raw)
    lines = d.get(:decorated).split("\n")
    assert_equal lines.first,                '<pre>'
    assert_equal lines.count,                26
    assert_equal lines.last,                 '</pre>'
    assert_equal 'textfile_path.4',           d.get(:id)
    assert_equal filepath,                    d.get(:screen)
  end
end
