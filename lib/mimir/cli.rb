# coding: utf-8
require 'json'
require_relative 'usage'
require_relative 'version'

module Mimir
  class CLI
    def initialize(argv)
      commands_file_name = File.join(File.dirname(__FILE__), %w{commands commands.json})
      begin
        commands_json = File.read(commands_file_name)
      rescue => e
        puts e.message
      end
      values = {}
      values[:program]  = 'mimir'
      values[:commands] = JSON.parse(commands_json)
      @usage    = Mimir::Usage.new(values).render()
    end

    def run
      puts VERSION if ARGV[0] == '--version'
      puts @usage if ARGV.empty? or ARGV[0] == '-h' or ARGV[0] == '--help'
      # system('ruby -Ilib lib/mimir/commands/help/cmd.rb 1 2 3')
    end
  end
end
