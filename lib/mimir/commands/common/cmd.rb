# coding: utf-8
require 'mimir/usage'
require 'mimir/options'

usage_file = File.expand_path(File.join('usage.erb'), File.dirname(__FILE__))
usage = Mimir::Usage.new(file: usage_file, command: ARGV[0]).render()
puts options = Mimir::Options.new(usage).parse()
