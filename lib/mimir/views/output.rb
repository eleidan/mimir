# coding: utf-8
require_relative 'plainview'
require_relative 'jsonview'

module Mimir
  module View

    class Result
      attr_accessor :values
      def render(file)
        ERB.new(File.read(file), nil, '-').result(binding)
      end
    end

  end
end
