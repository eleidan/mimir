# coding: utf-8
require_relative 'base'

module Mimir
  module Views

    class Plain < Base
      def initialize(params={})
        super
        @values = @options[:data]
      end

      def render()
        name = 'output_ugly.txt.erb'
        name = 'output_pretty.txt.erb' if @options['--pretty'] == true
        super(compose_template_file_path(name))
      end


    private
      def compose_template_file_path(name)
        File.join(@options[:path], name)
      end
    end

  end
end
