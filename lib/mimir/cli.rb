# coding: utf-8
require_relative 'version'
require_relative 'command'
require_relative 'view/usage'

module Mimir
  class CLI
    def initialize(argv)
      values = {}
      values[:program]  = 'mimir'
      values[:commands] = get_commands()
      @commands = values[:commands].keys()
      @usage    = Mimir::View::Usage.new(values).render()
    end

    def run
      # Print version and exit
      if ARGV[0] == '--version'
        puts VERSION
        exit 0
      end
      # Print help and exit
      if ARGV.empty? or ARGV[0] == '-h' or ARGV[0] == '--help'
        puts @usage
        exit 0
      end
      # Try to execute the command otherwise.
      if @commands.include?(ARGV[0])
        Mimir::Command.new(ARGV).run
      else
        puts @usage
        exit 1
      end
    end

    def get_commands()
      commands_file_name = File.join(File.dirname(__FILE__), %w{commands commands.txt})
      begin
        result = {}
        lines = File.readlines(commands_file_name)
        lines.each do |line|
          cmd, desc = line.split(':::')
          result[cmd.strip] = desc.strip
        end
        result
      rescue => e
        puts e.message
      end
    end
  end
end
