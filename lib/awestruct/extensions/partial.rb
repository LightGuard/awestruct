module Awestruct
  module Extensions
    module Partial

      def partial(path, params = {})
        filename = File.join( '_partials', path )

        if !File.exists?( filename )
          $LOG.error "Could not find #{filename}" if $LOG.error?
          return nil
        end

        page = site.engine.load_site_page( filename )
        return nil if !page

        params.each do |k,v|
          page.send( "#{k}=", v )
        end if params

        page.partial = true
        from_site = site.partials.find {|p| p.source_path == page.source_path}

        if from_site
          from_site.dependencies.add_dependent self[:page]
          self[:page].dependencies.add_dependency from_site
          Awestruct::Dependencies.track_dependency(from_site)
        else
          page.dependencies.add_dependent self[:page]
          self[:page].dependencies.add_dependency page
          Awestruct::Dependencies.track_dependency(page)
          site.partials << page
        end
        page.content
      end

    end
  end
end
