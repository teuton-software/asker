
module Sinatra
  module SinatraFrontEnd
    module RouteFile

      def self.registered(app)
        app.get '/file/show/*.*' do |path,ext|
          @filename = path+"."+ext
          filepath = File.join( Project.instance.inputbasedir , @filename)
          content = load_file filepath
#          @filecontent = CodeRay.scan(content, ext.to_sym).div(:line_numbers => :table)
          @filecontent = "<pre>#{content}</pre>"
          @concepts = session['concepts']
          @current = File.dirname(filepath)
          erb :"file/show"
        end

        app.post '/file/new' do
          #"Params #{params.to_s}"
          #filepath = File.join( Project.instance.inputbasedir, params[:basedir], params[:filename] )
          filepath = File.join( params[:basedir], params[:filename] )
          if params[:type]=='file' then
            redirect "/file/create/#{filepath}"
          elsif params[:type]=='dir' then
            redirect "/dir/create/#{filepath}"
          end
        end

        app.get '/file/create/*' do
          @current=File.join( Project.instance.inputbasedir, params[:splat] )
          "Create file #{@current}"
          #erb :"dir/create"
        end
      end

    end
  end
end
