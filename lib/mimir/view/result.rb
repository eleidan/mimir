# coding: utf-8
require_relative 'base'

module Mimir
  module View

    class Result < Base
      def initialize(params={})
        super
      end

      def render
        result = case @options['--format']
        when 'json'
          render_json
        else
          render_plain
        end
        puts result
      end

    private
      def render_json
        require_relative 'jsonview'
        Mimir::View::JsonView.new(@options).render
      end
      def render_plain
        require_relative 'plain'
        Mimir::View::Plain.new(@options).render
      end
    end

  end
end
