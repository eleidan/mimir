# coding: utf-8
require_relative 'options'
require_relative 'usage'

module Mimir
  class CLI
    def initialize(argv)
      values = {}
      values[:program]  = 'mimir'
      values[:commands] = {dump: 'description', diff: 'description'}
      @usage    = Mimir::Usage.new(values).render()
      @options  = Mimir::Options.new(argv, @usage).parse()
    end

    def run
      puts @usage if @options.empty?
    end
  end
end
