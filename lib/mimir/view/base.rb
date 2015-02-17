# coding: utf-8
require 'erb'

module Mimir
  module View

    class Base
      attr_reader :values
      def initialize(params={})
        defaults  = {'--format' => 'plain'}
        defaults.store('--pretty', 'false')
        @options  = defaults.merge(params)
      end

      def render(file)
        ERB.new(File.read(file), nil, '-').result(binding)
      end
    end

  end
end
