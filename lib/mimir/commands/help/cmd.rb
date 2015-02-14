# coding: utf-8
# require 'mimir/view/usage'
# require 'mimir/options'
#
# usage_file = File.expand_path(File.join('usage.erb'), File.dirname(__FILE__))
# usage = Mimir::View::Usage.new(file: usage_file).render()
# options = Mimir::Options.new(usage).parse()
#
# # Get path to the command
# command = options['<command>']
# commands_usage_file = File.join(usage_file.split(File::SEPARATOR)[0..-3], command, 'usage.erb')
# puts usage = Mimir::View::Usage.new(file: commands_usage_file, command: command).render()
puts 'MIMIR!'
def help(options)
  puts 'Hi there!'
  puts options
end
