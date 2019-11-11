# frozen_string_literal: true

require_relative '../sinatra/sinatra_front_end'

# Asker#editor
class Asker < Thor
  map ['e', '-e', '--editor'] => 'editor'
  desc 'editor', '(UNDER DEVELOPMENT) Run web platform editor'
  def editor
    SinatraFrontEnd.run!
  end
end
