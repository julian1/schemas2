
# http://geoexamples.com/other/2015/06/04/Jekyll-tags-plugin-gh-pages.html

# Could use symbolic linking rather than this hardlinking.
# or just symlink the entire directories once and reference
# Only really need the script for generating the zip which cannot be done... 


module Jekyll
  class TagsGenerator < Generator

    def do_copying(mcp_dir, dest_folder)

      regenerate_flag = false

      if !Dir.exists?(dest_folder)
        puts "Creating dest dir #{dest_folder}"
        Dir.mkdir(dest_folder)
      end

      Dir.glob( [ mcp_dir + '/schema.xsd', mcp_dir + '/schema/extensions/*.*' ]).each do |f|
        i = File.basename f
        puts "file #{ i }"
        if !File.exists?(dest_folder + '/' + i)
          puts "copying to #{dest_folder}"
          FileUtils.cp(f, dest_folder) 
          regenerate_flag = true
        end
      end
      # trigger regeneration
      if regenerate_flag
        FileUtils.touch Dir.pwd+'/_config.yml'
      end
    end


    def generate(site)
      puts "current dir #{ Dir.pwd }"

      mcp_dir = Dir.pwd + '/schema-plugins/iso19139.mcp-2.0/'
      dest_folder = Dir.pwd + '/public/download/mcp-2.0/'
      do_copying(mcp_dir, dest_folder)

      mcp_dir = Dir.pwd + '/schema-plugins/iso19139.mcp-1.4/'
      dest_folder = Dir.pwd + '/public/download/mcp-1.4/'
      do_copying(mcp_dir, dest_folder)
    end

  end
end




