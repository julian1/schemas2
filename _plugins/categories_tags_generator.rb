
# http://geoexamples.com/other/2015/06/04/Jekyll-tags-plugin-gh-pages.html

# Could just symbolic link rather than this hardlinking. Issue is that it exposes all the other files in mcp-2.0/schemas.
# or just symlink the entire directories once and reference
# Only really need the script for generating the zip which cannot be done...

require 'zip'

module Jekyll
  class TagsGenerator < Generator


    def do_copying(mcp_dir, dest_folder)

      regenerate_flag = false

      files = Dir.glob( [ mcp_dir + '/schema.xsd', mcp_dir + '/schema/extensions/*.*' ])

      # determine relative path set
      mappings = []
      files.each do |f|
        # preserve nested file structure
        relative =  Pathname.new(f).relative_path_from(Pathname.new(mcp_dir))
        mappings << { src: f, dst: relative.to_s }
      end

      puts mappings

      # create copy in correct dir
      mappings.each do |mapping|
        dst = dest_folder + '/' + mapping[:dst]
        dir = File.dirname dst
        if !Dir.exists?(dir)
          puts "Creating dest dir #{dir}"
          FileUtils.mkdir_p(dir)
        end

        if !File.exists?(dst)
          FileUtils.cp_r(mapping[:src], dst)
          regenerate_flag = true
        end
      end

      if regenerate_flag

        # trigger regeneration
        FileUtils.touch Dir.pwd+'/_config.yml'

        # create zip
        zipfile_name = Dir.pwd + '/my.zip'

        # cleanest way to empty the zip
        FileUtils.rm(zipfile_name)
        Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
          mappings.each do |mapping|
            # Two arguments:
            # - The name of the file as it will appear in the archive
            # - The original file, including the path to find it
            zipfile.add(mapping[:dst], mapping[:src])
          end
        end

      end

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




