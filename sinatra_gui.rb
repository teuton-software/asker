
require "sinatra/base"

class SinatraGUI < Sinatra::Base
  BASEDIR="./input"

  get '/' do
    redirect '/list'
  end

  get '/list' do
    @current=File.join(BASEDIR)
    load_dir @current
    erb :list
  end

  get '/list/*' do
    @current=File.join(BASEDIR, params[:splat])
    load_dir @current
    erb :list
  end

  get '/show/*.*' do |path,ext|
    @filename = path+"."+ext
    filepath=File.join(BASEDIR, @filename)
    load_file filepath
    @current = File.dirname(filepath)
    erb :show
  end

  def load_dir(dir)
    @filenames = Dir[dir+"/**"].sort!
  end

  def load_file(filename)
    @filecontent=open(filename) { |i| i.read }
  end

  helpers do
    def route_for(path)
      items=path.split(File::SEPARATOR)
      items.delete(".")
      items.delete("input")
      return items.join(File::SEPARATOR)
    end

    def html_for_current
      items=@current.split(File::SEPARATOR)
      items.delete(".")
      items.delete("input")

      output=""
      before=""
      items.each do |i|
        if i==items.last then
          output += " » "+i
        else
          before=before+"/"+i
          output += " » <a href=\"/list"+before+"/\">"+i+"</a>"
        end
      end
      return output
    end
  end

#  run!
end

#DartSinatraGUI.run!
