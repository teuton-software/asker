# frozen_string_literal: true

require 'fileutils'
require 'rainbow'
require_relative 'version'

# Skeleton: create skeleton for asker input files
# * create
# * create_main_dir_and_files
# * create_dir
# * create_dirs
# * copyfile
module Skeleton
  ##
  # Create skeleton for asker input files
  # @param inputpath (String)
  # rubocop:disable Metrics/MethodLength
  def self.create_input(inputpath)
    puts "\n[INFO] Creating example input #{Rainbow(inputpath).bright}"
    if File.extname(inputpath) == '.haml'
      dirpath = File.dirname(inputpath)
      filename = File.basename(inputpath)
    else
      dirpath = inputpath
      filename = 'example-concept.haml'
    end
    create_dir dirpath
    source = File.join(File.dirname(__FILE__), 'files/example-concept.haml')
    copyfile(source, File.join(dirpath, filename))
  end
  # rubocop:enable Metrics/MethodLength

  ##
  # Create default configuration files
  def self.create_configuration
    puts "\n[INFO] Creating configuration files"
    src = File.join(File.dirname(__FILE__), 'files', Version::CONFIGFILE)
    dst = File.join(Version::CONFIGFILE)
    copyfile(src, dst)
  end

  ##
  # Create folder
  # @param dirpath (String)
  private_class_method def self.create_dir(dirpath)
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
  private_class_method def self.copyfile(target, dest)
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
