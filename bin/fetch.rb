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

brew = Brewski.fetch(name)

if brew.formula.stable.version.to_s == brew.feed.version
  vdiff = '(current)'
else
  vdiff = "(new, current: #{brew.formula.stable.version})"
end

output =<<EOF
version: #{brew.feed.version} #{vdiff}
url: #{brew.feed.url}
EOF
puts output

if options[:write] && brew.formula.stable.version.to_s != brew.feed.version
  old_version = brew.formula.stable.version.to_s
  new_version = brew.feed.version

  old_sha256 = brew.formula.stable.checksum.to_s
  new_sha256 = Brewski.shasum(brew.feed.url)

  formula = Brewski.read_formula(name)
  formula.gsub!(/#{old_version}/, new_version)
  formula.gsub!(/#{old_sha256}/, new_sha256)
  Brewski.write_formula(name, formula)
end
