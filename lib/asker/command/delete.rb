# frozen_string_literal: true

require 'fileutils'

# Command Line User Interface
class Asker < Thor
  map ['--delete'] => 'delete'
  desc 'delete', 'Delete files from output directory'
  def delete
    puts '[INFO] Cleaing output directory...'
    dir = Project.instance.get(:outputdir)
    FileUtils.rm_rf(Dir.glob(File.join('.', dir, '*')))
  end
end
