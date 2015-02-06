# coding: utf-8
require 'json'
require_relative 'usage'
require_relative 'version'

module Mimir
  class CLI
    def initialize(argv)
      values = {}
      values[:program]  = 'mimir'
      values[:commands] = get_commands()
      @commands = values[:commands].keys()
      @usage    = Mimir::Usage.new(values).render()
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
        # command = ARGV.shift
        command = ARGV[0]
      else
        puts @usage
        exit 1
      end
      command_file = File.join( File.dirname(__FILE__), 'commands', command, 'cmd.rb')
      system(['ruby', '-Ilib', command_file, ARGV].join(' '))
    end

    def get_commands()
      commands_file_name = File.join(File.dirname(__FILE__), %w{commands commands.json})
      begin
        commands_json = File.read(commands_file_name)
        JSON.parse(commands_json)
      rescue => e
        puts e.message
      end
    end
    def validate_args()

    end
  end
end
