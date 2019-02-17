
require 'rainbow'
require_relative '../tool'

class Asker < Thor

  map ['f', '-f', '--file'] => 'file'
  desc 'file NAME', 'Build output files, from HAML/XML input file.'
  option :nocolor, :type => :boolean
  long_desc <<-LONGDESC
  Build output files, from input file (HAML/XML format).

  It builds questions about contents into input file specified.
  This is the most usefull function.
  These are 3 ways of use it:

  #{Rainbow($PROGRAM_NAME + ' file input/foo/foo.haml').yellow}, Build questions from HAML file\n
  #{Rainbow($PROGRAM_NAME + ' file input/foo/foo.xml').yellow}, Build questions from XML file\n
  #{Rainbow($PROGRAM_NAME + ' file projects/foo/foo.yaml').yellow}, Build questions from YAML project file\n

LONGDESC
  def file(name)
    Rainbow.enabled = false if options[:nocolor]
    Tool.new.start(name)
  end

  def method_missing(m, *_args, &_block)
    file(m.to_s)
  end
end
