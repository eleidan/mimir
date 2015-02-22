# coding: utf-8
require_relative 'base'

module Mimir
  module Views

    class Result < Base
      def initialize(params={})
        super
        get_renderer
      end

      def render()
        puts @renderer.render
      end

    private
      def get_renderer
        @renderer = case @options['--format']
        when 'json'
          require_relative 'jsonview'
          Mimir::Views::JsonView.new(@options)
        else
          require_relative 'plain'
          Mimir::Views::Plain.new(@options)
        end
      end
    end # Result

  end
end
