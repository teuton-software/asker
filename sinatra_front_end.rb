
require "sinatra/base"
require 'coderay'

require_relative 'lib/loader/file_loader'
require_relative 'lib/project'
require_relative 'lib/sinatra/helpers'
require_relative 'lib/sinatra/route_concept'
require_relative 'lib/sinatra/route_dir'
require_relative 'lib/sinatra/route_file'

class SinatraFrontEnd < Sinatra::Base
  use Rack::Session::Pool

  helpers  Sinatra::SinatraFrontEnd::Helpers
  register Sinatra::SinatraFrontEnd::RouteConcept
  register Sinatra::SinatraFrontEnd::RouteDir
  register Sinatra::SinatraFrontEnd::RouteFile

  get '/' do
    redirect '/dir/list'
  end

  def load_dir(dir)
    @filenames = Dir[dir+"/**"].sort!
  end

  def load_file(filename)
    return open(filename) { |i| i.read }
  end

end
