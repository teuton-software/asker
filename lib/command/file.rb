# frozen_string_literal: true

require 'rainbow'
require_relative '../tool'

# Asker#file
class Asker < Thor
  map ['f', '-f', '--file'] => 'file'
  desc 'file NAME', 'Build output files, from HAML/XML input file.'
  option :color, :type => :boolean
  long_desc <<-LONGDESC
  Create output files, from input file (HAML/XML format).

  Build questions about contents defined into input file specified.

  Examples:

  1) #{Rainbow('asker input/foo/foo.haml').yellow}, Build questions from HAML file.\n
  2) #{Rainbow('asker input/foo/foo.xml').yellow}, Build questions from XML file.\n
  3) #{Rainbow('asker file --no-color input/foo/foo.haml').yellow}, Same as (1) but without colors.\n
  4) #{Rainbow('asker projects/foo/foo.yaml').yellow}, Build questions from YAML project file.\n

  LONGDESC
  def file(name)
    Rainbow.enabled = false unless options['color']
    Tool.new.start(name)
  end

  def method_missing(method, *_args, &_block)
    file(method.to_s)
  end
end
