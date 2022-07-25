# frozen_string_literal: true

require 'rss'
require 'open-uri'
require 'pry'

class ValidPairs
  def initialize(params)
    @pairs = params
  end

  def get
    @pairs[Random.new.rand(0...@pairs.count)]
  end
end

class Topics
  def initialize(params)
    @pairs = params
  end

  def get
    @pairs[Random.new.rand(0...@pairs.count)]
  end
end

def fetch_topics(url)
  items = []
  URI.parse(url).open do |rss|
    feed = RSS::Parser.parse(rss)
    # puts feed.channel.title
    feed.items.each do |item|
      items << item.title
    end
  end
  items
end

def fetch_elpais(url)
  items = []
  URI.parse(url).open do |rss|
    feed = RSS::Parser.parse(rss)
    feed.items.each do |item|
      title = item.title
      categories = item.categories.map(&:content)
      items << OpenStruct.new(title: title, categories: categories)
    end
  end
  items
end

def replace(params)
  title = params[:pais].title
  old_categories = categories_on_title(params[:pais])
  puts old_categories
  cat = old_categories[Random.new.rand(0..old_categories.count - 1)]
  topic = params[:topic]

  # case-insensitive
  title.sub(/#{cat}/i, topic)
end

def categories_on_title(pair)
  pair.categories.select { |c| pair.title.split.map(&:capitalize).join(' ').include?(c) }
end

def titles_with_categories(pairs)
  pairs.select { |p| categories_on_title(p).count.positive? }
end

def main
  topics = Topics.new(fetch_topics('https://trends.google.es/trends/trendingsearches/daily/rss?geo=AR'))
  elpais = fetch_elpais('https://feeds.elpais.com/mrss-s/pages/ep/site/elpais.com/section/america/portada')

  valid_pairs = ValidPairs.new(titles_with_categories(elpais))

  puts replace(pais: valid_pairs.get,
               topic: topics.get)
end

main
