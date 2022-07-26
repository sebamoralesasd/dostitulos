# frozen_string_literal: true

module DosTitulos
  # Página que provee los títulos de las noticias a consumir.
  class Feed
    attr_reader :pairs

    def initialize(url)
      fetch_elpais(url)
    end

    # Obtener noticias del portal elpais.com
    #
    # @param url [String]
    def fetch_elpais(url)
      @pairs = []
      URI.parse(url).open do |rss|
        feed = RSS::Parser.parse(rss)
        feed.items.each do |item|
          title = item.title
          categories = item.categories.map(&:content)
          @pairs << OpenStruct.new(title: title, categories: categories)
        end
      end
    end
  end
end
