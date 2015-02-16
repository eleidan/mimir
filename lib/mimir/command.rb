# coding: utf-8
require_relative 'view/usage'
require_relative 'view/result'
require_relative 'options'

module Mimir
  class Command
    attr_reader :command_options, :usage_content
    def initialize(args)
      @command = args[0]
      @location = locate_myself()
      @usage_file_path = ''
      @command_file_path = dispatch()
      @usage_content = 'No content.'
      @command_options = {}
      locate_usage_file(@command_file_path)
      render_usage()
      parse_options()
      # system((['ruby', '-Ilib', dispatch, ARGV].join(' ')))

      # yield @command_options, @usage_content if block_given?
    end
    def run
      require @command_file_path
      # eval("#{@command}(@command_options)")
    end

    def locate_usage_file(file)
      @usage_file_path = File.expand_path('usage.erb', File.dirname(file))
    end
    def render_usage
      @usage_content = Mimir::View::Usage.new(file: @usage_file_path).render()
    end

    def parse_options
      @command_options = Mimir::Options.new(@usage_content).parse()
    end


    def locate_command_file
      File.join(@location, %W(commands #{@command} cmd.rb))
    end

    def dispatch
      locate_command_file
    end

  private
    def locate_myself
      File.dirname(__FILE__)
    end
  end
end
