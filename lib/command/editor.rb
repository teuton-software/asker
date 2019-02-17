
require_relative '../sinatra/sinatra_front_end'

class Asker < Thor

  map ['e', '-e', '--editor'] => 'editor'
  desc 'editor', 'Run web platform editor'
  def editor
    SinatraFrontEnd.run!
  end

end
