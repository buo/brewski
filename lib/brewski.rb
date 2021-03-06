# encoding: utf-8

require 'hashie'
require 'pathname'

BREWSKI_PATH = Pathname.new(__FILE__).realpath.parent.parent
BREWSKI_FEED_PATH = BREWSKI_PATH.join('feed')
BREWSKI_LIBRARY_PATH = BREWSKI_PATH.join('lib')
$:.unshift BREWSKI_PATH
$:.unshift BREWSKI_LIBRARY_PATH
require 'brewski/config'
require 'brewski/shasum'
require 'feed'

HOMEBREW_PATH = Pathname.new(`brew --repository`.strip).realpath
HOMEBREW_FORMULA_PATH = HOMEBREW_PATH.join('Library', 'Formula')
HOMEBREW_LIBRARY_PATH = HOMEBREW_PATH.join('Library', 'Homebrew')
#$:.unshift HOMEBREW_FORMULA_PATH
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
    mash = Hashie::Mash.new
    mash.feed = load_feed(name)
    mash.formula = load_formula(name)
    mash
  end

  def self.load_feed(name)
    path = BREWSKI_FEED_PATH.join("#{name}.rb")
    contents = File.open(path, 'rb') do |handle|
      handle.read
    end
    feed = Feed.new(name)
    eval(contents, feed.get_binding)
    feed
  end

  def self.load_formula(name)
    path = HOMEBREW_FORMULA_PATH.join("#{name}.rb")
    Formulary.load_formula_from_path(name, path)
  end

  def self.read_formula(name)
    path = HOMEBREW_FORMULA_PATH.join("#{name}.rb")
    path.open("r").read
  end

  def self.write_formula(name, contents)
    path = HOMEBREW_FORMULA_PATH.join("#{name}.rb")
    path.open("w") do |f|
      f.write contents
    end
  end
end
