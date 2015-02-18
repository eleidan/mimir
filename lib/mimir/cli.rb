# coding: utf-8
require_relative 'version'
require_relative 'command'
require_relative 'view/usage'

module Mimir
  class CLI
    attr_reader   :values, :commands, :usage
    attr_accessor :stdout
    def initialize(stdout=STDOUT)
      @stdout = stdout
      @values = {}
      @values[:program]  = 'mimir'
      @values[:commands] = Mimir::CLI::get_commands()
      @commands = values[:commands].keys().sort()
      @usage    = Mimir::View::Usage.new(@values).render()
      self
    end

    def run
      # Print version and exit
      if ARGV[0] == '--version'
        @stdout.puts VERSION
        exit 0
      end
      # Print help and exit
      if ARGV.empty? or ARGV[0] == '--help'
        @stdout.puts @usage
        exit 0
      end
      # Try to execute the command otherwise.
      if @commands.include?(ARGV[0])
        Mimir::Command.new(ARGV).run
      else
        @stdout.puts @usage
        exit 1
      end
    end

    def self.get_commands(file='')
      file_name = file.empty? ? File.join(File.dirname(__FILE__),\
                                      %w{commands commands.txt}) \
                              : file
      result = {}
      begin
        lines = File.readlines(file_name)
        lines.each do |line|
          cmd, desc = line.split(':::')
          result[cmd.strip] = desc.strip
        end
      rescue => e
        puts e.message
      end

      result
    end
  end
end
