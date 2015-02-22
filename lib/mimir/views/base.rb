# coding: utf-8
require 'erb'

module Mimir
  module Views

    class Base
      attr_reader :values
      def initialize(params={})
        raise ArgumentError unless params.instance_of?(Hash)
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
