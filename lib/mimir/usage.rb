# coding: utf-8
require 'erb'

module Mimir
  class Usage
    attr_accessor :program, :commands
    def initialize(params={})
      params[:program]  ||= 'mimir'
      params[:commands] ||= {}
      params[:file] ||= File.expand_path(File.join('commands','usage.erb'), \
                                         File.dirname(__FILE__))

      @program  = params[:program]
      @commands = params[:commands]
      @file     = params[:file]
    end

    def render(file='')
      file = @file if file.empty?
      ERB.new(File.read(file), nil, '-').result(binding)
    end
  end
end
