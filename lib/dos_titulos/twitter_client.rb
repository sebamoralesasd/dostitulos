# frozen_string_literal: true

require 'twitter'

def client
  Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV.fetch('TWITTER_APP_CONSUMER_KEY', nil)
    config.consumer_secret     = ENV.fetch('TWITTER_APP_CONSUMER_SECRET', nil)
    config.access_token        = ENV.fetch('TWITTER_ACCESS_TOKEN', nil)
    config.access_token_secret = ENV.fetch('TWITTER_ACCESS_TOKEN_SECRET', nil)
  end
end
