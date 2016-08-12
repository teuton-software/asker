
module Sinatra
  module SinatraFrontEnd
    module Helpers

      BASEDIR=Project.instance.inputbasedir

      def route_for(path)
        items=path.split(File::SEPARATOR)
        items.delete(".")
        items.delete(BASEDIR)
        return items.join(File::SEPARATOR)
      end

      def remove_basedir(dir)
        items=@current.split(File::SEPARATOR)
        items.delete(".")
        items.delete("..")
        items.delete(BASEDIR)
        return File.join(items,File::SEPARATOR)
      end

      def html_for_current( option={ :indexlast => false} )
        items=@current.split(File::SEPARATOR)
        items.delete(".")
        items.delete("..")
        items.delete(BASEDIR)

        output="<a href=\"/dir/list\">Home</a>"
        before=""
        items.each do |i|
          if i==items.last and option[:indexlast]==false then
            output += "/"+i
          else
            before=before+"/"+i
            output += "/<a href=\"/dir/list"+before+"/\">"+i+"</a>"
          end
        end
        return output
      end

    end
  end
end
