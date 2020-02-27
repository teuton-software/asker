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
  ##
  # Create skeleton for asker input files
  # @param dirpath (String) Folder path to save example files
  def self.create(dirpath)
    puts "\n[INFO] Creating #{Rainbow(dirpath).bright} project skeleton"
    create_dir dirpath
    copy_files_into(dirpath)
  end

  ##
  # Copy lib/asker/files into Folder
  # @param dirpath (String)
  def self.copy_files_into(dirpath)
    # Directory and files: example-concept.haml
    source = File.join(File.dirname(__FILE__), 'files/example-concept.haml')
    target = File.join(dirpath, 'example-concept.haml')
    copyfile(source, target)
  end

  ##
  # Create folder
  # @param dirpath (String)
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

  ##
  # Copy target file to dest
  # @param target (String)
  # @param dest (String)
  def self.copyfile(target, dest)
    if File.exist? dest
      puts "* Exists file!      => #{Rainbow(dest).yellow}"
      return true
    end
    begin
      FileUtils.cp(target, dest)
      puts "* Create file       => #{Rainbow(dest).green}"
    rescue StandardError
      puts "* Create file ERROR => #{Rainbow(dest).red}"
    end
  end
end
