
require 'rainbow'
require_relative '../application'

# Class method Asker#download
class Asker < Thor

  map ['--download'] => 'download'
  desc 'download', 'Download Asker example inputs from git repo'
  long_desc <<-LONGDESC
  - Download Asker inputs from git repo.

  - Same as:
    git clone https://github.com/dvarrui/asker-inputs.git

  Example:

  #{$PROGRAM_NAME} download

  LONGDESC
  def download
    repo = 'asker-inputs'
    puts "[INFO] Downloading <#{repo}> repo..."
    system("git clone https://github.com/dvarrui/#{repo}.git")
    puts "[INFO] Your files are into <#{Rainbow(repo).bright}> directory..."
  end
end
