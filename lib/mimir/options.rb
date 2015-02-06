# coding: utf-8
require 'docopt'
require_relative 'version'

module Mimir
  class Options
    def initialize(usage, options={})
      defaults = {argv: ARGV, help: true}
      @options = defaults.merge(options)
      @usage   = usage
      @result  = nil
    end

    def parse()
      begin
        @result = Docopt::docopt(@usage, @options)
      rescue Docopt::Exit => e
        puts e.message
        exit 0
      end
      skip_false_options
      skip_empty_arguments
      @result
    end

  private
    def skip_false_options()
      @result.reject! {|k,v| v === false}
    end

    def skip_empty_arguments()
      @result.reject! {|k,v| v === nil}
    end
  end
end
