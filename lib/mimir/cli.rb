# coding: utf-8
require_relative 'options'

module Mimir
  class CLI

    def initialize(argv)
      Mimir::Options::new(argv)
    end

    def run

    end

  end
end
