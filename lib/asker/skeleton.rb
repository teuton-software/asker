# frozen_string_literal: true

require 'fileutils'
require 'rainbow'

# Skeleton: create skeleton for asker input files
# * create
# * create_main_dir_and_files
# * create_dir
# * create_dirs
# * copyfile
module Skeleton
  def self.create(project_dir)
    project_name = File.basename(project_dir)
    puts "\n[INFO] Creating #{Rainbow(project_name).bright} project skeleton"
    create_dir project_dir
    copy_files_into(project_dir)
  end

  def self.copy_files_into(project_dir)
    # Directory and files: Ruby script, Configfile, gitignore
    items = [
      { source: 'files/example-concept.haml', target: 'example-concept.yaml' },
      { source: 'files/example-code.haml', target: 'example-code.haml.rb' },
    ]
    source_basedir = File.join(File.dirname(__FILE__))
    items.each do |item|
      source = File.join(source_basedir, item[:source])
      target = File.join(project_dir, item[:target])
      copyfile(source, target)
    end
  end

  def self.create_dir(dirpath)
    if Dir.exist? dirpath
      puts "* Exists dir!       => #{Rainbow(dirpath).yellow}"
    else
      begin
        FileUtils.mkdir_p(dirpath)
        puts "* Create dir        => #{Rainbow(dirpath).green}"
      rescue StandardError
        puts "* Create dir  ERROR => #{Rainbow(dirpath).red}"
      end
    end
  end

  def self.create_dirs(*args)
    args.each { |arg| create_dir arg }
  end

  def self.copyfile(target, dest)
    if File.exist? dest
      puts "* Exists file!      => #{Rainbow(dest).yellow}"
    else
      puts "* File not found!   => #{Rainbow(target).yellow}" unless File.exist? target
      begin
        FileUtils.cp(target, dest)
        puts "* Create file       => #{Rainbow(dest).green}"
      rescue StandardError
        puts "* Create file ERROR => #{Rainbow(dest).red}"
      end
    end
  end
end
