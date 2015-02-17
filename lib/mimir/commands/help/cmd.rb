def command(options)
  usage_file = File.expand_path(File.join('usage.erb'), File.dirname(__FILE__))
  usage = Mimir::View::Usage.new(file: usage_file).render()
  command_name = options['<command>']
  # Get path to the command
  commands_usage_file = File.join(usage_file.split(File::SEPARATOR)[0..-3], command_name, 'usage.erb')
  puts usage = Mimir::View::Usage.new(file: commands_usage_file, command: command_name).render()
end
