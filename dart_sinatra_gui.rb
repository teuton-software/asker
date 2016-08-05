
require "sinatra/base"

class DartSinatraGUI < Sinatra::Base
  BASEDIR="./input"

  get '/' do
    redirect '/ls'
  end

  get '/ls' do
    @current=File.join(BASEDIR)
    load_dir
    erb :list
  end

  get '/ls/*' do
    @current=File.join(BASEDIR, params[:splat])
    load_dir
    erb :list
  end

  def load_dir
    @filenames = Dir[@current+"/**"].sort!
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
          output += " | "+i
        else
          before=before+"/"+i
          output += " | <a href=\"/ls"+before+"/\">"+i+"</a>"
        end
      end
      return output
    end
  end

#  run!
end

#DartSinatraGUI.run!
