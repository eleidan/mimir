# coding: utf-8

module Mimir
  module Services
    def get_all_methods(cls)
      eval(cls).methods.sort
    end

    def get_private_methods(cls, all=false)
      eval(cls).private_methods(all).sort
    end

    def get_instance_methods(cls, all=false)
      eval(cls).instance_methods(all).sort
    end
  end
end
