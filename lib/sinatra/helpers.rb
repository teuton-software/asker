
# Sintatra.SinatraFrontEnd.Helpers
module Sinatra
  module SinatraFrontEnd
    module Helpers

      BASEDIR = Project.instance.inputbasedir

      def route_for(path)
        s = BASEDIR.size + 1
        return path[s,100]
#        items = path.split(File::SEPARATOR)
#        items.delete(".")
#        items.delete(BASEDIR)
#        return items.join(File::SEPARATOR)
      end

      def remove_basedir(dir)
        items=@current.split(File::SEPARATOR)
        items.delete(".")
        items.delete("..")
        items.delete(BASEDIR)
        return File.join(items,File::SEPARATOR)
      end

      def html_for_current( option={ :indexlast => false} )
#        items=@current.split(File::SEPARATOR)
#        items.delete(".")
#        items.delete("..")
#        items.delete(BASEDIR)
        output = "<a href=\"/dir/list\">Home</a>"
        relative_path = route_for @current
        return output if relative_path.nil?

        items = relative_path.split(File::SEPARATOR)

        #binding.pry if option[:indexlast] == true

        before = ""
        items.each do |i|
          if i==items.last and option[:indexlast]==false then
            output += "/"+i
          else
            before=before+"/"+i
            output += "/<a href=\"/dir/list"+before+"\">"+i+"</a>"
          end
        end
        return output
      end

      def html_for_navbar
        text= <<-DIV
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand"   href="/">ASKER</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="/">Home</a></li>
            <li><a href="https://github.com/dvarrui/asker">GitHub</a></li>
            <li><a href="https://github.com/dvarrui/asker/blob/master/README.md">About</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      DIV
      return text
      end

    end
  end
end
