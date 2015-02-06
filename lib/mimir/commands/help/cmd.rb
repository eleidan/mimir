# coding: utf-8
require 'mimir/usage'
require 'mimir/options'

usage_file = File.expand_path(File.join('usage.erb'), File.dirname(__FILE__))
# puts usage = Mimir::Usage.new(file: usage_file).render()
usage = Mimir::Usage.new(file: usage_file).render()
# puts "HELP", ARGV
puts options = Mimir::Options.new(usage).parse()
puts usage if options.empty?
