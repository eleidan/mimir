# coding: utf-8
require_relative 'base'

module Mimir
  module View

    class Plain < Base
      def render(file='')
        # super(file)
        # ERB.new(File.read(file), nil, '-').result(binding)
      end
    end

  end
end
