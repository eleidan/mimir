require 'mimir/services/help'

include Mimir::Services

def command(opts)
  defaults  = {'--format' => 'plain'}
  options   = defaults.merge(opts)
  the_class = Mimir::Options::get_option(options,'<class>').strip
  # the_format  = Mimir::Options::get_option(options,'--format').downcase
  # Refactoring TODO: extract method for lines below
  methods = {}
  tmp = get_class_public_methods(the_class)
  methods['public methods']     = tmp if tmp.size > 0
  tmp = get_class_protected_methods(the_class)
  methods['protected methods']  = tmp if tmp.size > 0
  tmp = get_class_private_methods(the_class)
  methods['private methods']    = tmp if tmp.size > 0
  # Refactoring TODO: extract method for lines below
  result  = {}
  result.store(the_class, methods)
  # Inject data
  options[:data] = result
  # puts options[:data]
  # output  = Mimir::View::Result.new(options).render()
  # puts output
  return options
end
