require 'awestruct/astruct'
require 'tilt'
require 'mime-types'

module Awestruct
  class Page < Awestruct::AStruct

    attr_reader :dependencies
    attr_reader :layout
    attr_reader :front_matter         # DONE
    attr_reader :relative_source_path # DONE
    attr_reader :output_path          # DONE
    attr_reader :output_filename      # DONE -- need more tests to determine if all file types are accounted
    attr_reader :source_path          # DONE
    attr_reader :raw_content          # DONE
    attr_reader :rendered_content
    attr_reader :content

    def initialize(resource, site)
      @site = site
      front_matter = []
      raw_content = []

      read_file file, site
      super @front_matter
    end
    
    def render()
    end

    def ==

    end

    private
    def read_file(resource, site) 
      # TODO: read each line, separate out the front matter, everything else becomes raw_content
      if (File.exist?(File.join(site.config.dir, resource)) && File.file?(File.join(site.config.dir, resource)))
        resource_content = File.open(File.join(site.config.dir, resource)).readlines
        @source_path = Pathname.new(File.join(site.config.dir, resource)).relative_path_from(Pathname.new site.config.dir).to_s
      else # Assume resource is a string
        resource_content = resource.split(/\n/)
      end

      in_front_matter = false
      resource_content.each do |line|
        if /^---$/ =~ line
          in_front_matter = !in_front_matter
          next
        end
        if in_front_matter
          front_matter << line
        else
          raw_content << line
        end
        @front_matter = YAML.load front_matter.join
        @raw_content = raw_content.join + front_matter.join
        @content = raw_content.join
      end
      if Tilt[@source_path]
        @template = Tilt.new File.join site.config.dir, @source_path
        mime_type = Tilt[@source_path].default_mime_type
        unless mime_type
          # Can't rely on the mime-type from Tilt because it isn't there

          case (File.basename(@source_path).split('.').last)
            when 'md'
              mime_type = 'text/html'
          end
        end
        output_extension = MIME::Types[mime_type].first.extensions.first
        @output_filename = File.basename(@source_path).split('.').first + '.' + output_extension
      elsif @source_path
        @output_filename = File.basename(@source_path)
      end

      super @front_matter
    end

    def output_path()
      Pathname.new(File.join(@site.output_dir, File.dirname(@source_path), @output_filename)).to_s
    end

    def render()
    end

    def ==
    end
  end
end
