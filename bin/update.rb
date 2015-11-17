#!/usr/bin/env ruby
# coding: utf-8

require 'optparse'

$LOAD_PATH.unshift File.expand_path('../../lib/', __FILE__)
require 'brewski'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: fetch.rb [options]"

  opts.on("-w", "--write", "Write update") do |w|
    options[:write] = w
  end
end.parse!

fetch = File.expand_path('../fetch.rb', __FILE__)
Brewski.each_feed do |name|
  system fetch, "#{name}", "-w"
end
