# coding: utf-8
require 'mimir/command'
require 'mimir/services'

include Mimir::Services
Mimir::Command.new(__FILE__) do |opts, usage|
  defaults  = {'--format' => 'plain'}
  options   = defaults.merge(opts)
  the_class   = Mimir::Options::get_option(options,'<class>').strip
  the_format  = Mimir::Options::get_option(options,'--format').downcase
  methods = {}
  methods['public methods'] = get_class_public_methods(the_class)
  methods['protected methods'] = get_class_protected_methods(the_class)
  methods['private methods'] = get_class_private_methods(the_class)
  result = {}
  result.store(the_class, methods)
  if the_format == 'json'
    require 'json'
    puts JSON.pretty_generate(result)
  end
  puts result
end
