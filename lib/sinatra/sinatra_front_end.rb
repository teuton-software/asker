
require "sinatra/base"
require 'coderay'

require_relative '../loader/file_loader'
require_relative '../project'
require_relative 'helpers'
require_relative 'route_concept'
require_relative 'route_dir'
require_relative 'route_file'

class SinatraFrontEnd < Sinatra::Base
  use Rack::Session::Pool

  set :root, File.join( File.dirname(__FILE__), "..", ".." )
  set :views, Proc.new { File.join(root, "views") }

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
