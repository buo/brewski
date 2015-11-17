require 'curb'
require 'github_api'
require 'json'
require 'nokogiri'

class Feed
  attr_reader :version
  attr_reader :url, :sha256

  def initialize(name)
    @name = name
  end

  def get_binding
    binding()
  end

  def github(owner, repo, options = {})
    options[:draft] = false if options[:draft].nil?
    options[:prerelease] = false if options[:prerelease].nil?
    hub = Github.new oauth_token: Brewski.config["github_token"]
    releases = hub.repos.releases.list owner: owner, repo: repo
    releases = releases.select do |release|
      release.draft == options[:draft] and release.prerelease == options[:prerelease]
    end
  end

  def html(url)
    curl = Curl::Easy.new(url) do |c|
      c.follow_location = true
      c.headers['User-Agent'] = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/600.8.9 (KHTML, like Gecko) Version/8.0.8 Safari/600.8.9'
      #c.verbose = true
    end
    curl.perform
    Nokogiri::HTML(curl.body_str)
  end

  def json(url)
    resp = Curl.get(url)
    JSON.parse(resp.body_str)
  end
end
