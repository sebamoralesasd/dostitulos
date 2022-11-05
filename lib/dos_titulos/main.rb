# frozen_string_literal: true

require 'rss'
require 'open-uri'
require 'pry'

require_relative 'valid_pairs'
require_relative 'topics'
require_relative 'feed'
require_relative 'dos_titulos'

module DosTitulos
  # Ejecución principal.
  class Main
    # Generar el título alterado.
    def dos_titulos
      topics = Topics.new('https://trends.google.com.ar/trends/trendingsearches/daily/rss?geo=AR')
      elpais = Feed.new('https://feeds.elpais.com/mrss-s/pages/ep/site/elpais.com/section/america/portada')

      generator = DosTitulos.new
      valid_pairs = ValidPairs.new(generator.titles_with_categories(elpais))

      generator.replace(feed: valid_pairs.get, topic: topics.get)
    end

    # Ejecución principal.
    def main
      puts dos_titulos
    end
  end
end

DosTitulos::Main.new.main
