
module Sinatra
  module SinatraFrontEnd
    module RouteConcept

      def self.registered(app)
        app.get '/concept/list/*.*' do |path,ext|
          @filename = path+"."+ext
          filepath = File.join(Project.instance.inputbasedir, @filename)
          data = FileLoader.load(filepath)
          @concepts = data[:concepts]
          @lang = @concepts[0].lang
          @context = @concepts[0].context

          session[ 'concepts' ] = @concepts

          @current = File.dirname( filepath )
          erb :"concept/list"
        end

        app.get '/concept/show/:index' do
          @index = params[:index]
          @concepts = session['concepts']
          @concept = @concepts[ @index.to_i ]

          puts ConceptHAMLFormatter.new(@concept).to_s

          @filename = @concept.filename
          @current  = File.dirname( File.join( Project.instance.inputbasedir, @filename) )
          erb :"concept/show"
        end
      end

    end
  end
end
