module Awestruct
  class Page
    attr_reader :dependencies
    attr_reader :layout
    attr_reader :front_matter

    def initialize(file, site)
      @front_matter = []
      parse_front_matter
    end

    def render()
    end

    private
    def parse_front_matter()

    end
  end
end
