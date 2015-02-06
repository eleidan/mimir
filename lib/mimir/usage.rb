# coding: utf-8
require 'erb'

module Mimir
  class Usage
    attr_accessor :values
    def initialize(params={})
      defaults = {program: 'mimir', commands: {}}
      defaults[:file] = File.expand_path(File.join('commands','usage.erb'), \
                                         File.dirname(__FILE__))
      @values   = defaults.merge(params)
    end

    def render(file='')
      file = @values[:file] if file.empty?
      ERB.new(File.read(file), nil, '-').result(binding)
    end
  end
end
