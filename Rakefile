require "bundler/gem_tasks"

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features)
rescue LoadError
  puts "Cucumber is not available. In order to run features, you must: sudo gem install cucumber"
end

begin
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new(:spec)
  task :default => :spec
rescue LoadError
  puts "RSpec is not available. In order to run specs, you must: sudo gem install rspec"
end

namespace :mimir do

  def get_commands(files)
    result = {}
    files.each do |file_name|
      command_desc =  File.open(file_name) do |f|
                        f.readline.strip
                      end
      command_name =  File.dirname(file_name).split(File::SEPARATOR).last
      result[command_name] = command_desc unless command_name=='commands'
    end
    result
  end

  def save_commands(commands, file)
    File.open(file, 'w') do |f|
      commands.each_pair do |command, desc|
        f.puts("#{command} ::: #{desc}")
      end
    end
  end

  desc  'Generate the list of available commands'
  task  :commands do
    commands_file_pattern = File.join(%w{lib mimir commands ** usage.erb})
    files = Dir.glob(commands_file_pattern)
    commands = get_commands(files)
    commands_file_name = File.join(%w{lib mimir commands commands.txt})
    save_commands(commands, commands_file_name)
  end
end
