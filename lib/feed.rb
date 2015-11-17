require 'curb'
require 'nokogiri'

class Feed
  attr_reader :url, :version

  def initialize(name)
    @name = name
  end

  def get_binding
    binding()
  end

  def html(url)
    curl = Curl::Easy.new(url) do |c|
      c.follow_location = true
      c.headers['User-Agent'] = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/600.8.9 (KHTML, like Gecko) Version/8.0.8 Safari/600.8.9'
      c.verbose = true
    end
    curl.perform
    Nokogiri::HTML(curl.body_str)
  end
end
