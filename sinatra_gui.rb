
require "sinatra/base"
require 'coderay'
require_relative 'lib/loader/file_loader'
require_relative 'lib/project'

class SinatraGUI < Sinatra::Base
  BASEDIR=Project.instance.inputbasedir # "./input"

  enable :sessions

  get '/' do
    redirect '/dir/list'
  end

  get '/dir/list' do
    @current=File.join(BASEDIR)
    load_dir @current
    erb :"dir/list"
  end

  get '/dir/list/*' do
    @current=File.join(BASEDIR, params[:splat])
    load_dir @current
    erb :"dir/list"
  end

  get '/file/show/*.*' do |path,ext|
    @filename = path+"."+ext
    filepath=File.join(BASEDIR, @filename)
    content = load_file filepath
    @filecontent = CodeRay.scan(content, ext.to_sym).div(:line_numbers => :table)
    @current = File.dirname(filepath)
    erb :"file/show"
  end

  get '/concept/list/*.*' do |path,ext|
    @filename = path+"."+ext
    filepath = File.join(BASEDIR, @filename)
    @concepts = FileLoader.new( filepath ).load
    @lang = @concepts[0].lang
    @context = @concepts[0].context

    session[ 'filename' ] = @filename.to_s
    session[ 'filepath' ] = filepath
    session[ 'lang'     ] = @lang.lang
    session[ 'context'  ] = @context.join(",").to_s

    @current = File.dirname( filepath )
    erb :"concept/list"
  end

  get '/concept/show/:index' do
    @filename = session['filename']
    filepath = session['filepath']
    @concepts = FileLoader.new( filepath ).load
    @concept = @concepts[ params[:index].to_i ]
    @current  = File.dirname( File.join(BASEDIR, @filename) )
    erb :"concept/show"
  end

  get '/read/:key' do
    "key = " << session[ params[:key] ]
    "session = " << session.inspect
  end

  get '/write/:key/:value' do
    "key = " << params[:key]
    "value = " << params[:value]
    session[ params[:key] ] = params[:value]
  end

  def load_dir(dir)
    @filenames = Dir[dir+"/**"].sort!
  end

  def load_file(filename)
    return open(filename) { |i| i.read }
  end

  helpers do
    def route_for(path)
      items=path.split(File::SEPARATOR)
      items.delete(".")
      items.delete(BASEDIR)
      return items.join(File::SEPARATOR)
    end

    def html_for_current( option={ :indexlast => false} )
      items=@current.split(File::SEPARATOR)
      items.delete(".")
      items.delete(BASEDIR)

      output=""
      before=""
      items.each do |i|
        if i==items.last and option[:indexlast]==false then
          output += " » "+i
        else
          before=before+"/"+i
          output += " » <a href=\"/dir/list"+before+"/\">"+i+"</a>"
        end
      end
      return output
    end
  end

end
