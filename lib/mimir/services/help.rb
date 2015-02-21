module Mimir
  module Services
    require 'set'
    SUSPECTED = '/\\[]{}~`!@#$%^&*()_+,.;\'"?'.chars.to_set


    def valid?(input)
      if input.chars.to_set.intersect?(SUSPECTED)
        STDERR.puts 'Provided data looks strange!'
        false
      else
        true
      end
    end

    # TODO: remove?
    def remove_empty_items(arg)
      arg.reject! {|k,v| v.empty?}
    end

    # ************************************************************************
    # Class related methods
    def get_methods(cls)
      return {} unless valid?(cls)
      puts obj = get_instance(cls)
      result = {
        'public'  => {
          'class'     => get_class_public_methods(cls),
          'instance'  => get_instance_public_methods(obj)
        },
        'protected'  => {
          'class'     => get_class_protected_methods(cls),
          'instance'  => get_instance_protected_methods(obj)
        },
        'private'  => {
          'class'     => get_class_private_methods(cls),
          'instance'  => get_instance_private_methods(obj)
        }
      }

      result
    end

    def get_class_public_methods(cls)
      eval(cls).public_methods(false).sort
    end

    def get_class_protected_methods(cls)
      eval(cls).protected_methods(false).sort
    end

    def get_class_private_methods(cls)
      eval(cls).private_methods(false).sort
    end

    # ************************************************************************
    # Instance related methods

    def get_instance_public_methods(obj)
      return [] if obj.nil?
      obj.public_methods(false).sort
    end

    def get_instance_protected_methods(obj)
      return [] if obj.nil?
      obj.protected_methods(false).sort
    end

    def get_instance_private_methods(obj)
      return [] if obj.nil?
      obj.private_methods(false).sort
    end

    def has_new?(cls)
      Object::const_get(cls).respond_to?(:new)
    end

    def get_instance(cls)
      return 1 if cls == 'Fixnum'
      return nil unless has_new?(cls)
      Object::const_get(cls).new
    end
  end
end
