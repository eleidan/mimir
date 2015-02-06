# coding: utf-8
require_relative 'usage'
require_relative 'options'

module Mimir
  class Command
    attr_reader :command_options, :usage_content
    def initialize(file)
      @usage_file_path = ''
      @usage_content = 'No content.'
      @command_options = {}
      locate_usage_file(file)
      render_usage()
      parse_options()
      yield @command_options, @usage_content if block_given?
    end

    def locate_usage_file(file)
      @usage_file_path = File.expand_path('usage.erb', File.dirname(file))
    end

    def render_usage
      @usage_content = Mimir::Usage.new(file: @usage_file_path).render()
    end
    def parse_options()
      @command_options = Mimir::Options.new(@usage_content).parse()
    end
  end
end
