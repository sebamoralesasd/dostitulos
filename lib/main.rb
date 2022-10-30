# frozen_string_literal: true

require 'rss'
require 'open-uri'
require 'pry'

require_relative 'valid_pairs'
require_relative 'topics'
require_relative 'feed'

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
