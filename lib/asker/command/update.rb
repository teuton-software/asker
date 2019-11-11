# frozen_string_literal: true

require 'rainbow'

# Class method Teuton#update
class Asker < Thor
  map ['--update', '-u', 'u'] => 'update'
  desc 'update', 'Update ASKER from git repo'
  long_desc <<-LONGDESC
  Update ASKER project, downloading files from git repo.
  Execute "cd PATH/TO/ASKER/DIR && git pull".

  Aliases: asker u, asker -u, asker --update

  LONGDESC
  def update
    dir = File.absolute_path(File.join(File.dirname(__FILE__), '..', '..'))
    ok = system("cd #{dir} && git pull")
    if ok
      puts Rainbow('[ OK ] asker update').green.bright
      exit(0)
    else
      puts Rainbow('[FAIL] asker update').red.bright
      exit(1)
    end
  end
end
