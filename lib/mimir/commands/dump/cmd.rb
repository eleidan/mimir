require 'mimir/services/help'

include Mimir::Services

def command(opts)
  defaults  = {'--format' => 'plain'}
  options   = defaults.merge(opts)
  the_class = Mimir::Options::get_option(options,'<class>').strip
  result  = {
    the_class => {
      # 'constants' => Hash.new,
      'methods'   => get_methods(the_class),
      # 'values'    => Hash.new
    }
  }
  options[:data] = result

  options
end
