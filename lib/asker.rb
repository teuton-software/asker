#!/usr/bin/ruby

require 'thor'
require_relative 'asker/command/main'

# Command Line User Interface
class Asker < Thor
  map ['h', '-h', '--help'] => 'help'
end
