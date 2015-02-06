# coding: utf-8
require 'mimir/command'
require 'mimir/services'

include Mimir::Services
Mimir::Command.new(__FILE__) do |options, usage|
  puts get_all_methods(options['<class>']) if options.has_key?('<class>')
end
