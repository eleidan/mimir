# coding: utf-8
require_relative 'base'

module Mimir
  module Views

    class Usage < Base
      def initialize(params={})
        defaults  = {program: 'mimir', commands: {}}
        defaults[:file] = File.expand_path(File.join('..', 'commands','usage.erb'), \
                                           File.dirname(__FILE__))
        @values   = defaults.merge(params)
      end

      def render()
        file = @values[:file]
        super(file)
      end
    end

  end
end
