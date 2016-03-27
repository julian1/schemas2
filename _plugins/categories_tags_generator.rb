
# http://geoexamples.com/other/2015/06/04/Jekyll-tags-plugin-gh-pages.html

# Could just symbolic link rather than this hardlinking. Issue is that it exposes all the other files in mcp-2.0/schemas.
# or just symlink the entire directories once and reference
# Only really need the script for generating the zip which cannot be done... 


module Jekyll
  class TagsGenerator < Generator

    def do_copying(mcp_dir, dest_folder)

      regenerate_flag = false


      Dir.glob( [ mcp_dir + '/schema.xsd', mcp_dir + '/schema/extensions/*.*' ]).each do |f|

        # preserve nested file structure
        relative =  Pathname.new(f).relative_path_from(Pathname.new(mcp_dir))
        i = dest_folder + '/' + relative.to_s

        # we don't want the basename but the subtraction  
        #i = File.basename f
        puts "file src #{ f }"
        puts "file dst #{ i }"

        x = File.dirname i

        if !Dir.exists?(x)
          puts "Creating dest dir #{x}"
          FileUtils.mkdir_p(x)
        end

        if !File.exists?( i)
          FileUtils.cp_r(f, i) 
          regenerate_flag = true
        end
      end
      # trigger regeneration
      if regenerate_flag
        FileUtils.touch Dir.pwd+'/_config.yml'
      end
    end

    def generate_empty(site)

    end

    def generate(site)
      puts "current dir #{ Dir.pwd }"

      mcp_dir = Dir.pwd + '/schema-plugins/iso19139.mcp-2.0/'
      dest_folder = Dir.pwd + '/mcp-2.0/'
      do_copying(mcp_dir, dest_folder)

      mcp_dir = Dir.pwd + '/schema-plugins/iso19139.mcp-1.4/'
      dest_folder = Dir.pwd + '/mcp-1.4/'
      do_copying(mcp_dir, dest_folder)
    end

  end
end




