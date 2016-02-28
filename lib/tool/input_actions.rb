#!/usr/bin/ruby
# encoding: utf-8

module InputActions

  def load_input_files
	app=Application.instance
    verbose "\n[INFO] Loading input data..."
		
    inputdirs=app.inputdirs.split(',')
    inputdirs.each do |dirname|
      if !Dir.exists? dirname then
        raise "[ERROR] <#{dirname}> directory dosn't exist!"
      end
      files=(Dir.new(dirname).entries-[".",".."]).sort
      filter = files.select { |f| f[-4..-1]==".xml" || f[-5..-1]==".haml" } # filter only HAML or XML files
      verbose "[INFO] HAML/XML files from #{dirname}: #{filter.join(', ').to_s} "
		
      filter.each do |f|
        pFilename=dirname+'/'+f
        if pFilename[-5..-1]==".haml" then
          template = File.read(pFilename)
          haml_engine = Haml::Engine.new(template)
          lFileContent = haml_engine.render
        else
          lFileContent=open(pFilename) { |i| i.read }				
        end
				
        begin
          puts " * Processing <#{pFilename}> file"
          lXMLdata=REXML::Document.new(lFileContent)
          
          begin
            lang=lXMLdata.root.attributes['lang']
		  rescue
		    lang=app.lang
		  end
		  
          lXMLdata.root.elements.each do |i|
            if i.name=='concept' then
              c=Concept.new(i,lang)
              c.process=false
              if ( app.process_file==:default or app.process_file==f.to_s ) then
                c.process=true
              end
              @concepts[c.name]=c
            end
          end
        rescue REXML::ParseException
          verbose "[ERROR] Format error in file <"+pFilename+">!"
          raise "[ERROR] Format error in file <"+pFilename+">!"
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
