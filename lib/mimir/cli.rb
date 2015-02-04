# coding: utf-8
require_relative 'options'

module Mimir
  class CLI
    attr_accessor :cmds, :program
    def initialize(argv)
      cmds     = {dump: 'description', diff: 'description'}
      Mimir::Options.new(argv).parse()
    end

    def run

    end

  end
end
