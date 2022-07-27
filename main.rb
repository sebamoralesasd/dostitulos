# frozen_string_literal: true

require 'rss'
require 'open-uri'
require 'pry'

# ValidPairs representa a los pares de titulos y categorias
# en donde un titulo contenga un topico en su definición.
# Esto es, [(t, c) : c es substring de t].
class ValidPairs
  def initialize(params)
    @pairs = params
  end

  def get
    @pairs[Random.new.rand(0...@pairs.count)]
  end
end

# Tópico o categoría de una noticia.
class Topics
  def initialize(url)
    fetch_topics(url)
  end

  def fetch_topics(url)
    @pairs = []
    URI.parse(url).open do |rss|
      feed = RSS::Parser.parse(rss)
      # puts feed.channel.title
      feed.items.each do |item|
        @pairs << item.title
      end
    end
  end

  def get
    @pairs[Random.new.rand(0...@pairs.count)]
  end
end

# Página que provee los títulos de las noticias a consumir.
class Feed
  attr_reader :pairs

  def initialize(url)
    fetch_elpais(url)
  end

  def fetch_elpais(url)
    @pairs = []
    URI.parse(url).open do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.each do |item|
        title = item.title
        # puts item.categories
        categories = item.categories.map(&:content)
        @pairs << OpenStruct.new(title: title, categories: categories)
      end
    end
  end
end

# Toma un feed y un tópico y modifica al título
# obtenido del feed con dicho tópico.
def replace(params)
  title = params[:feed].title
  old_categories = categories_on_title(params[:feed])
  puts old_categories
  cat = old_categories[Random.new.rand(0..old_categories.count - 1)]
  topic = params[:topic]

  # case-insensitive
  title.sub(/#{cat}/i, topic)
end

# Dado un par (titulo, topicos) verifica si el titulo
# contiene algún tópico en su definición.
def categories_on_title(pair)
  pair.categories.select { |c| pair.title.split.map(&:capitalize).join(' ').include?(c) }
end

# Filtra los pares (titulo, topicos) que cumplan con categories_on_title.
def titles_with_categories(feed)
  pairs = feed.pairs
  pairs.select { |p| categories_on_title(p).count.positive? }
end

def main
  topics = Topics.new('https://trends.google.com.ar/trends/trendingsearches/daily/rss?geo=AR')
  elpais = Feed.new('https://feeds.elpais.com/mrss-s/pages/ep/site/elpais.com/section/america/portada')

  valid_pairs = ValidPairs.new(titles_with_categories(elpais))

  puts replace(feed: valid_pairs.get,
               topic: topics.get)
end

main
