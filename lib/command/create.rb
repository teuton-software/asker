require_relative 'lib/builder/builder'

# Command Line User Interface
class Asker < Thor

  map ['c', '-c', '--create'] => 'create'
  desc 'create PROJECTNAME', 'Create files for a new project'
  long_desc <<-LONGDESC
  ADVANCED FUNCTION

  Create new FOO project. Example:

  > #{$PROGRAM_NAME} create foo

LONGDESC
  def create(projectname)
    Builder.create_project(projectname)
  end

end
