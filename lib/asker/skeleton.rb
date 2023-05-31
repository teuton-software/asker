# frozen_string_literal: true

require "fileutils"
require "rainbow"
require_relative "version"

class Skeleton
  ##
  # Create skeleton for asker input files
  # @param inputpath (String)
  def create_input(inputpath)
    puts "\n[INFO] Creating example input #{Rainbow(inputpath).bright}"
    if File.extname(inputpath) == ".haml"
      dirpath = File.dirname(inputpath)
      filename = File.basename(inputpath)
    else
      dirpath = inputpath
      filename = "example-concept.haml"
    end
    create_dir dirpath
    source = File.join(File.dirname(__FILE__), "files", "example-concept.haml")
    copyfile(source, File.join(dirpath, filename))
  end

  def create_configuration
    puts "\n[INFO] Creating configuration files"
    src = File.join(File.dirname(__FILE__), "files", Asker::CONFIGFILE)
    dst = File.join(Asker::CONFIGFILE)
    copyfile(src, dst)
  end

  private

  def create_dir(dirpath)
    if Dir.exist? dirpath
      puts "* Exists dir!       => #{Rainbow(dirpath).yellow}"
    else
      begin
        FileUtils.mkdir_p(dirpath)
        puts "* Create dir        => #{Rainbow(dirpath).green}"
      rescue
        puts "* Create dir  ERROR => #{Rainbow(dirpath).red}"
      end
    end
  end

  def copyfile(target, dest)
    if File.exist? dest
      puts "* Exists file!      => #{Rainbow(dest).yellow}"
      return true
    end
    begin
      FileUtils.cp(target, dest)
      puts "* Create file       => #{Rainbow(dest).green}"
    rescue
      puts "* Create file ERROR => #{Rainbow(dest).red}"
    end
  end
end
