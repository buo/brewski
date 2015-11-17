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

name = ARGV.first

feed = Brewski.fetch(name)
output =<<EOF
version: #{feed.version}
url: #{feed.url}
EOF
puts output
