# coding: utf-8

module Mimir
  module Services
    require 'set'
    SUSPECTED = '/\\[]{}~`!@#$%^&*()_+,.;\'"?'.chars.to_set

    def get_class_public_methods(cls)
      return [] unless valid?(cls)  # TODO: Use custom Exception.
      eval(cls).public_methods(false).sort
    end

    def get_class_protected_methods(cls)
      return [] unless valid?(cls)  # TODO: Use custom Exception.
      eval(cls).protected_methods(false).sort
    end

    def get_class_private_methods(cls)
      return [] unless valid?(cls)  # TODO: Use custom Exception.
      eval(cls).private_methods(false).sort
    end

    def valid?(input)
      if input.chars.to_set.intersect?(SUSPECTED)
        $stderr.puts 'Provided data looks strange!'
      else
        true
      end
    end

  end
end
