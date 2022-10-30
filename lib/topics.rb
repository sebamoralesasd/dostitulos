# frozen_string_literal: true

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
