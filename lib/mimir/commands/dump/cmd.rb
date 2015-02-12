# coding: utf-8
require 'mimir/command'
require 'mimir/services'

include Mimir::Services

Mimir::Command.new(__FILE__) do |args, usage|
  defaults  = {'--format' => 'plain'}
  options   = defaults.merge(args)
  the_class   = Mimir::Options::get_option(options,'<class>').strip
  # the_format  = Mimir::Options::get_option(options,'--format').downcase
  # Refactoring TODO: extract method for lines below
  methods = {}
  methods['public methods'] = get_class_public_methods(the_class)
  methods['protected methods'] = get_class_protected_methods(the_class)
  methods['private methods'] = get_class_private_methods(the_class)
  # Refactoring TODO: extract method for lines below
  result = {}
  result.store(the_class, methods)
  # Inject data
  options[:data] = result
  # puts options[:data]
  output = Mimir::View::Result.new(options).render()
  puts output
end
