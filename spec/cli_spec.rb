require 'spec_helper'

module Mimir
  describe CLI do
    describe '#new' do
      context 'without arguments' do
        let(:cli)         { Mimir::CLI.new }
        it 'should not return nil' do
          expect(cli).not_to be nil
        end
        it 'should set attributes properly' do
          expect(cli.values[:program]).to       eq('mimir')
          expect(cli.values[:commands]).to      be_an_instance_of(Hash)
          expect(cli.values[:commands]).not_to  be_empty
          expect(cli.usage).to      be_an_instance_of(String)
          expect(cli.usage).not_to  be_empty
          expect(cli.argv).to       be_an_instance_of(Array)
        end
      end
      context 'with an argument ["--version"]' do
        let(:cli)         { Mimir::CLI.new(['--version']) }
        it 'should set @argv to array' do
          expect(cli.argv).to       be_an_instance_of(Array)
          expect(cli.argv).to       eq ['--version']
        end
      end
    end # new

    describe '#run' do
      context 'when application is issued without any argument' do
        let(:cli)         { Mimir::CLI.new([]) }
        it 'should print help and exit' do
          expect {cli.run}.to (output(/Introspection utility/).to_stdout)\
                    .and raise_exception SystemExit
        end
      end

      context 'when application is issued without any supported argument' do
        let(:cli)         { Mimir::CLI.new(['--fake']) }
        it 'should print help and exit' do
          expect {cli.run}.to (output(/Introspection utility/).to_stdout)\
                    .and raise_exception SystemExit
        end
      end

      context 'when application is issued with "--version" option' do
        let(:cli)         { Mimir::CLI.new(['--version']) }
        it 'should print application version and exit' do
          expect {cli.run}.to (output(/#{Mimir::VERSION}/).to_stdout)\
                    .and raise_exception SystemExit
        end
      end

      context 'when application is issued with "dump" command' do
        let(:cli)         { Mimir::CLI.new(['dump']) }
        it 'should print usage for the command and exit' do
          expect {cli.run}.to \
                    (output(/mimir dump/).to_stdout)\
                    .and raise_exception SystemExit
        end
      end

      context 'when application is issued with "dump Hash" command' do
        let(:cli)         { Mimir::CLI.new(%w{dump Hash}) }
        it 'should print help for the command and exit' do
          expect {cli.run}.to output(/Hash/).to_stdout
        end
      end
    end # run

    describe '::get_commands' do
      context 'without argument, reading real data' do
        before do
          @result = Mimir::CLI::get_commands
        end
        it 'should not return nil' do
          expect(@result).not_to  be nil
        end
        it 'should return a Hash object' do
          expect(@result).to      be_an_instance_of(Hash)
        end
        it 'should not return empty hash' do
          expect(@result).not_to  be_empty
        end
      end

      context 'with an argument, reading fake data' do
        before do
          file_name = File.join(File.dirname(__FILE__), 'commands.txt')
          @result   = Mimir::CLI::get_commands(file_name)
          @commands = { 'ace'   => 'Description of ace', \
                        'base'  => 'Description of base' }
        end
        it 'should not return nil' do
          expect(@result).not_to  be nil
        end
        it 'should return a Hash object' do
          expect(@result).to      be_an_instance_of(Hash)
        end
        it 'should return particular set of commands' do
          expect(@result).to      eq(@commands)
        end
      end

      context 'with not existing file' do
        it 'should complain' do
          expect(File.exist?('fake.file')).to  eq false
          expect {Mimir::CLI::get_commands('fake.file')}.to \
                                                    raise_exception SystemExit
        end
      end
    end # get_commands
  end
end
