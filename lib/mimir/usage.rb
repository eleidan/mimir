# coding: utf-8
require 'erb'

module Mimir
  class Usage
    attr_accessor :program, :commands, :command, :values
    def initialize(params={})
      defaults = {program: 'mimir', commands: {}}
      defaults[:file] = File.expand_path(File.join('commands','usage.erb'), \
                                         File.dirname(__FILE__))

      # @program  = params[:program]
      # @commands = params[:commands]
      # @command  = params[:command] if params.has_key?(:command)
      # @file     = params[:file]
      @values   = defaults.merge(params)
    end

    def render(file='')
      file = @values[:file] if file.empty?
      ERB.new(File.read(file), nil, '-').result(binding)
    end
  end
end
