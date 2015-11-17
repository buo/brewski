# encoding: utf-8

require 'pathname'

BREWSKI_PATH = Pathname.new(__FILE__).realpath.parent.parent
BREWSKI_FEED_PATH = BREWSKI_PATH.join('feed')
BREWSKI_LIBRARY_PATH = BREWSKI_PATH.join('lib')
$:.unshift BREWSKI_PATH
$:.unshift BREWSKI_LIBRARY_PATH
require 'feed'

HOMEBREW_PATH = Pathname.new(`brew --repository`.strip).realpath
HOMEBREW_FORMULA_PATH = HOMEBREW_PATH.join('Library', 'Formula')
HOMEBREW_LIBRARY_PATH = HOMEBREW_PATH.join('Library', 'Homebrew')
$:.unshift HOMEBREW_FORMULA_PATH
$:.unshift HOMEBREW_LIBRARY_PATH
require 'global'
require 'formula'
require 'formulary'

module Brewski
  def self.each_feed
    Dir.glob("#{BREWSKI_FEED_PATH}/*.rb") do |filename|
      name = File.basename(filename, ".rb")
      yield name
    end
  end

  def self.exist?(name)
    File.exist? BREWSKI_FEED_PATH.join("#{name}.rb")
  end

  def self.fetch(name)
    path = BREWSKI_FEED_PATH.join("#{name}.rb")
    contents = File.open(path, 'rb') do |handle|
      handle.read
    end
    feed = Feed.new(name)
    eval(contents, feed.get_binding)
    feed
  end

  def load_formula(name)
    path = HOMEBREW_FORMULA_PATH.join("#{name}.rb")
    Formulary.load_formula_from_path(name, path)
  end
end
