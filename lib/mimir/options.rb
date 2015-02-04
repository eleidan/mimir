# coding: utf-8
require "docopt"
require "erb"
require_relative "version"


module Mimir
  class Options
    attr_accessor :cmds, :program
    def initialize(argv)
      @program  = "mimir"
      @cmds     = {dump: 'description', diff: 'description'}
      usage_file = File.expand_path('commands/usage.erb', File.dirname(__FILE__))
      @doc = ERB.new(File.read(usage_file), nil, '-').result(binding())
      @doc = render_usage(usage_file)
      # puts @doc
      @command = ''
      @objects = []
      @options = nil
      # Get hash of options
      # @options.default = false

      begin
        @options = Docopt::docopt(@doc, argv: argv, version: VERSION)
      rescue => e
        puts e.message
        exit 1
      end
      # parse
      # validate
      # require "pp"
      # pp @options
      # @options
    end

    def render_usage(file)
      ERB.new(File.read(file), nil, '-').result(binding())
    end


  private

    def parse()
      skip_false_options
      skip_empty_arguments
      extract_class
      extract_command
    end

    def skip_false_options()
      @options.reject! {|k,v| v === false}
    end

    def skip_empty_arguments()
      @options.reject! {|k,v| v === nil}
    end

    def extract_class()
      @objects = @options.delete('<class>')
    end

    def extract_command()
      @command = @options.reject {|k,v| k.start_with?('-')}.keys[0]
      @options.delete(@command)
    end

    def extract_options()
      @options.reject! {|k,v| k.start_with?('-')}
    end

    def validate()
    end
  end
end
