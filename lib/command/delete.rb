#!/usr/bin/ruby
# encoding: utf-8

require 'fileutils'

# Command Line User Interface
class Asker < Thor

  map ['d', '-d', '--delete'] => 'delete'
  desc 'delete', 'Delete files from output directory'
  def delete
    puts "[INFO] Cleaing output directory..."
    dir = Project.instance.get(:outputdir)
    FileUtils.rm_rf(Dir.glob(File.join('.', dir, '*')))
  end

end
