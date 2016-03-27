
# http://geoexamples.com/other/2015/06/04/Jekyll-tags-plugin-gh-pages.html
module Jekyll
 class TagsGenerator < Generator

   def generate(site)
       tags_dir = Dir.pwd + '/tags'

#       if !Dir.exists?(tags_dir)
#           puts "Creating tags dir"
#           Dir.mkdir(tags_dir)
#       end
#       regenerate_flag = false

       # TODO actually generating markdown, 
       # cleaner to create yaml in data, and can then use anywhere.

    puts "current dir #{ Dir.pwd }"

#schema-plugins/iso19139.mcp-2.0/

#    Dir.glob(Dir.pwd + '/_posts/*.*').each do |f|


    mcpDir = Dir.pwd + '/schema-plugins/iso19139.mcp-2.0/'

    Dir.glob( mcpDir  + '/schema.xsd').each do |f|
      puts f
    end

    Dir.glob( mcpDir  + '/schema/extensions/*.*').each do |f|
      puts f
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

   end
 end
end

