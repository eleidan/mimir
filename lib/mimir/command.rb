# coding: utf-8
require_relative 'view/usage'
require_relative 'view/result'
require_relative 'options'

module Mimir
  class Command
    # attr_reader :command_options, :usage_content
    def initialize(args)
      @argv = args
      @command_name = args[0]
      @location = locate_myself()
      @usage_file_path = ''
      @usage_content = 'No content.'
      @command_options = {}
      locate_command_path
      locate_command_file
      locate_usage_file(@command_file_path)
      render_usage()
      parse_options()
    end

    def run
      require @command_file
      options = {path: @command_file_path}
      result = command(@command_options)
      # TODO: Use proper exception, test this moment
      raise 'NOT A HASH!' unless result.is_a?(Hash)
      options.merge!(result)
      Mimir::View::Result.new(options).render() unless result.empty?
    end

    def locate_usage_file(file)
      @usage_file_path = File.join(@command_file_path, 'usage.erb')
    end
    def render_usage
      @usage_content = Mimir::View::Usage.new(file: @usage_file_path).render()
    end

    def parse_options
      puts '>>>>'
      @command_options = Mimir::Options.new(@usage_content,{argv: @argv}).parse()
    end


    def locate_command_file
      @command_file = File.join(@command_file_path, 'cmd.rb')
    end
    def locate_command_path
      @command_file_path = File.join(@location, %W(commands #{@command_name}))
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
