
# http://geoexamples.com/other/2015/06/04/Jekyll-tags-plugin-gh-pages.html

# Could use symbolic linking rather than this hardlinking.
# Only really need this script for generating the zip which cannot be done... 


module Jekyll
 class TagsGenerator < Generator

   def generate(site)
       tags_dir = Dir.pwd + '/tags'


    puts "current dir #{ Dir.pwd }"

    regenerate_flag = false


    mcp_dir = Dir.pwd + '/schema-plugins/iso19139.mcp-2.0/'
    dest_folder = Dir.pwd + '/public/download/'

    Dir.glob( [ mcp_dir + '/schema.xsd', mcp_dir + '/schema/extensions/*.*' ]).each do |f|
 
      i = File.basename f
 
      # don't understand this... code looks wrong...
      puts "file #{ i }"
      if !File.exists?(dest_folder + '/' + i)
        puts "copying #{ f}"
        FileUtils.cp(f, dest_folder) 
        regenerate_flag = true
      end
    end


    # trigger regeneration
    if regenerate_flag
      FileUtils.touch Dir.pwd+'/_config.yml'
    end

   end
 end
end



# So we want to copy them into posts. 
# But probably not with current dir structure
# and create a zip
#      site.posts.each  do |i|
#          puts "*** WHOOT Creating tag page for: " + i[0]
#       end
#       if regenerate_flag
#           FileUtils.touch Dir.pwd+'/_config.yml'
#       end

#schema-plugins/iso19139.mcp-2.0/

#    Dir.glob(Dir.pwd + '/_posts/*.*').each do |f|

#       if !Dir.exists?(tags_dir)
#           puts "Creating tags dir"
#           Dir.mkdir(tags_dir)
#       end
#       regenerate_flag = false

       # TODO actually generating markdown, 
       # cleaner to create yaml in data, and can then use anywhere.

