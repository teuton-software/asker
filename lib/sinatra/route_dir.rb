
module Sinatra
  module SinatraFrontEnd
    module RouteDir

      def self.registered(app)
        app.get '/dir/list' do
          @current=File.join( Project.instance.inputbasedir)
          load_dir @current
          erb :"dir/list"
        end

        app.get '/dir/list/*' do
          @current=File.join( Project.instance.inputbasedir, params[:splat] )
          load_dir @current
          erb :"dir/list"
        end

        app.get '/dir/create/*' do
          @current=File.join( Project.instance.inputbasedir, params[:splat] )
          "Create dir #{@current}"
          #erb :"dir/create"
        end
      end

    end
  end
end
