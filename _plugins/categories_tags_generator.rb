
# http://geoexamples.com/other/2015/06/04/Jekyll-tags-plugin-gh-pages.html

# Could just symbolic link rather than this hardlinking. Issue is that it exposes all the other files in mcp-2.0/schemas.
# or just symlink the entire directories once and reference
# Only really need the script for generating the zip which cannot be done... 

require 'zip'

module Jekyll
  class TagsGenerator < Generator



    def createZip(zipfile_name, input_filenames)

      puts "WHOOT creating Zip! "

#      folder = "Users/me/Desktop/stuff_to_zip"
#      input_filenames = ['image.jpg', 'description.txt', 'stats.csv']
#      zipfile_name = "/Users/me/Desktop/archive.zip"

      #Zip::ZipFile.open(zipfile_name, Zip::ZipFile::CREATE) do |zipfile|
      Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
        input_filenames.each do |filename|
          # Two arguments:
          # - The name of the file as it will appear in the archive
          # - The original file, including the path to find it
          zipfile.add('x' + filename,  filename)
        end
      end
    end

    def createZip___OLD(path, files)

      puts "WHOOT creating Zip! "
      Zip::ZipFile.open(path, Zip::ZipFile::CREATE) do |z|
        files.each do |file|
          puts "adding #{file} to zip"

          source_path = "#{Rails.root}/public/webui/#{file}"
          expand_dirs(file).each do |dir|
            begin
              z.mkdir dir
            rescue Errno::EEXIST
            end
          end
          z.add file, source_path
        end
      end
    end

    def do_copying(mcp_dir, dest_folder)

      regenerate_flag = false

      files = Dir.glob( [ mcp_dir + '/schema.xsd', mcp_dir + '/schema/extensions/*.*' ])

      files.each do |f|

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

        createZip( Dir.pwd + '/my.zip', files )
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




