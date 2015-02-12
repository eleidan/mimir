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

      end

    private
      def render_json
        require_relative 'json'
        Mimir::View::Json.new(@options).render
      end
      def render_plain
        require_relative 'plain'
        Mimir::View::Plain.new(@options).render
      end
    end

  end
end
