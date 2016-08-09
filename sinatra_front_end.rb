
require "sinatra/base"
require 'coderay'

require_relative 'lib/loader/file_loader'
require_relative 'lib/project'
require_relative 'lib/sinatra/helpers'
require_relative 'lib/sinatra/route_file'

class SinatraFrontEnd < Sinatra::Base
  BASEDIR=Project.instance.inputbasedir

  use Rack::Session::Pool

  helpers  Sinatra::SinatraFrontEnd::Helpers
  register Sinatra::SinatraFrontEnd::RouteFile

  get '/' do
    redirect '/dir/list'
  end

  get '/dir/list' do
    @current=File.join(BASEDIR)
    load_dir @current
    erb :"dir/list"
  end

  get '/dir/list/*' do
    @current=File.join(BASEDIR, params[:splat] )
    load_dir @current
    erb :"dir/list"
  end

  get '/concept/list/*.*' do |path,ext|
    @filename = path+"."+ext
    filepath = File.join(BASEDIR, @filename)
    @concepts = FileLoader.new( filepath ).load
    @lang = @concepts[0].lang
    @context = @concepts[0].context

    session[ 'concepts' ] = @concepts

    @current = File.dirname( filepath )
    erb :"concept/list"
  end

  get '/concept/show/:index' do
    @index = params[:index]
    @concepts = session['concepts']
    @concept = @concepts[ @index.to_i ]
    @filename = @concept.filename
    @current  = File.dirname( File.join(BASEDIR, @filename) )
    erb :"concept/show"
  end

  def load_dir(dir)
    @filenames = Dir[dir+"/**"].sort!
  end

  def load_file(filename)
    return open(filename) { |i| i.read }
  end

end
