
require_relative '../builder/builder'

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
          Builder::create_dir(@current)
          load_dir @current
          erb :"dir/list"
        end
      end

    end
  end
end
