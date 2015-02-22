require 'json'
require_relative 'base'

module Mimir
  module Views

    class JsonView < Base
      def initialize(params={})
        super
        @data = @options[:data]
      end

      def render
        if @options['--pretty'] == true
          generate_pretty
        else
          generate_ugly
        end
      end

    private
      def generate_pretty
        JSON.pretty_generate(@data)
      end

      def generate_ugly
        JSON.generate(@data)
      end
    end

  end
end
