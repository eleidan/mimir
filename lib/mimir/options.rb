# coding: utf-8
require "docopt"
require_relative "version"
require_relative "usage"


module Mimir
  class Options
    def initialize(argv)
      @options  = nil
      @argv     = argv
    end

    def parse()
      doc = Usage.new().render()
      begin
        @options = Docopt::docopt(doc, argv: @argv, version: VERSION)
      rescue => e
        puts e.message
        exit 1
      end
      skip_false_options
      skip_empty_arguments
      extract_class
      extract_command
      # require "pp"
      # pp @options
      @options
    end

  private


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
