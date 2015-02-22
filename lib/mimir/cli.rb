# coding: utf-8
require_relative 'version'
require_relative 'command'
require_relative 'view/usage'

module Mimir
  class CLI
    attr_reader   :values, :commands, :usage, :argv
    def initialize(argv=ARGV)
      @argv   = argv
      @values = {}
      @values[:program]  = 'mimir'
      @values[:commands] = Mimir::CLI::get_commands()
      @commands = values[:commands].keys().sort()
      @usage    = Mimir::View::Usage.new(@values).render()
      self
    end

    def run
      # Print version and exit
      if @argv[0] == '--version'
        puts Mimir::VERSION
        exit 0
      end
      # Print help and exit
      if @argv.empty? or @argv[0] == '--help'
        puts @usage
        exit 0
      end
      # Try to execute the command otherwise.
      if @commands.include?(@argv[0])
        Mimir::Command.new(@argv).run
      else
        puts @usage
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
        STDERR.puts "Error while reading the list of availabe commands"
        exit 1
      end

      result
    end
  end
end
