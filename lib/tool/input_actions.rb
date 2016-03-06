#!/usr/bin/ruby
# encoding: utf-8

module InputActions

  def load_input_files
    app=Application.instance
    verbose "\n[INFO] Loading input data..."
		
    inputdirs=app.inputdirs.split(',')
    inputdirs.each do |dirname|
      if !Dir.exists? dirname then
        msg "["+Rainbow(ERROR).color(:red)+"] <#{Rainbow(dirname).color(:red)}> directory dosn't exist!"
        verboseln msg 
        raise msg
      end

      files=(Dir.new(dirname).entries-[".",".."]).sort
      accepted = files.select { |f| f[-4..-1]==".xml" || f[-5..-1]==".haml" } # accept only HAML or XML files
      verbose " * Input directory: #{Rainbow(dirname).bright}"

      flag=accepted.last
      accepted.each do |f|
        pFilename=dirname+'/'+f
        if pFilename[-5..-1]==".haml" then
          template = File.read(pFilename)
          haml_engine = Haml::Engine.new(template)
          lFileContent = haml_engine.render
        else
          lFileContent=open(pFilename) { |i| i.read }				
        end

        begin
          if flag==f then
            verbose "   └── Input file : #{Rainbow(pFilename).bright}..." 
          else
            verbose "   ├── Input file : #{Rainbow(pFilename).bright}..."
          end
          
          lXMLdata=REXML::Document.new(lFileContent)
          
          begin
            lLang=lXMLdata.root.attributes['lang'] # has lang attribute or not?
            lContext=lXMLdata.root.attributes['context']
		  rescue
		    lLang=app.lang
		    lContext="unknown"
		  end

          lXMLdata.root.elements.each do |xmldata|
            if xmldata.name=='concept' then
              c=Concept.new(xmldata,pFilename,lLang,lContext)
              c.process=false
              if ( app.process_file==:default or app.process_file==f.to_s ) then
                c.process=true
              end
              @concepts[c.name]=c
            end
          end
        rescue REXML::ParseException
          msg = Rainbow( "   │    [ERROR] Format error in file <#{pFilename}>! (InputActions#load_input_files)").color(:red)
          verbose msg
          raise msg
        end
      end
    end
		
    #find neighbors for every concept
    @concepts.each_value do |i|
      @concepts.each_value do |j|
        if (i.id!=j.id) then
          i.try_adding_neighbor j
        end
      end
    end
  end
end
