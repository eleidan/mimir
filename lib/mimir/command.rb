# coding: utf-8
require_relative 'views/usage'
require_relative 'views/result'
require_relative 'options'

module Mimir
  class Command
    attr_reader :location, :command_name, :command_options, :command_file, \
                :usage_file_path, :usage_content
    def initialize(args)
      raise ArgumentError unless args.instance_of?(Array)
      @argv = args
      @command_name = args[0]
      @location = locate_myself()
      @usage_file_path = ''
      @usage_content = 'No content.'
      @command_options = {}
      locate_command_path
      locate_command_file
      locate_usage_file @command_file_path
      render_usage
      parse_options
    end

    def run(cmd='')
      result = {}
      if cmd.empty?
        require @command_file
        options = {path: @command_file_path}
        result = command(@command_options)
      # For testing
      elsif cmd.instance_of?(String)
        result = eval(cmd)
      end
      raise 'The result of the command is not a Hash!' unless result.instance_of?(Hash)
      options.merge!(result)
      Mimir::Views::Result.new(options).render() unless result.empty?
    end

    def locate_usage_file(file)
      @usage_file_path = File.join(@command_file_path, 'usage.erb')
    end
    def render_usage
      @usage_content = Mimir::Views::Usage.new(file: @usage_file_path).render()
    end

    def parse_options
      @command_options = Mimir::Options.new(@usage_content,{argv: @argv}).parse()
    end


    def locate_command_file
      @command_file = File.join(@command_file_path, 'cmd.rb')
    end
    def locate_command_path
      @command_file_path = File.join(@location, %W(commands #{@command_name}))
    end

  private
    def locate_myself
      File.dirname(__FILE__)
    end
  end
end
