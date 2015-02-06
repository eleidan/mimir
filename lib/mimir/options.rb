# coding: utf-8
require "docopt"

module Mimir
  class Options
    def initialize(argv, usage)
      @options  = nil
      @argv     = argv
      @usage    = usage
    end

    def parse()
      begin
        @options = Docopt::docopt(@usage, \
                                  argv: @argv, \
                                  version: VERSION, \
                                  help: false)
      rescue Docopt::Exit => e
        puts e.message
        exit 0
      end
      skip_false_options
      skip_empty_arguments
      @options
    end

  private
    def skip_false_options()
      @options.reject! {|k,v| v === false}
    end

    def skip_empty_arguments()
      @options.reject! {|k,v| v === nil}
    end
  end
end
