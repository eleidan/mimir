require 'spec_helper'

module Mimir
  describe CLI do
    describe '#new' do
      before do
        @cli = Mimir::CLI.new
      end
      it 'should not return nil' do
        expect(@cli).not_to be nil
      end
      it 'should set attributes properly' do
        expect(@cli.values[:program]).to      eq('mimir')
        expect(@cli.values[:commands]).to     be_an_instance_of(Hash)
        expect(@cli.values[:commands]).not_to be_empty
        expect(@cli.usage).to     be_an_instance_of(String)
        expect(@cli.usage).not_to be_empty
      end
    end # new

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
        before do
          file_name = File.join(File.dirname(__FILE__), 'commands.txt')
        end
        it 'should complain' do
          expect{Mimir::CLI::get_commands(@file_name)}.to  raise_exception
        end
      end
    end # get_commands

    describe '#run' do
      let(:fake_output) { double('fake_output').as_null_object }
      let(:cli)         { Mimir::CLI.new(fake_output) }

      context 'when application is issued without any argument' do
        it 'should print help and exit' do
          expect(fake_output).to receive(:puts).with(/Introspection utility/)
          expect{cli.run}.to raise_error SystemExit
        end
      end

      context 'when application is issued without any supported argument' do
        it 'should print help and exit' do
          expect(fake_output).to receive(:puts).with(/Introspection utility/)
          expect{cli.run}.to raise_error SystemExit
        end
      end

      context 'when application is issued with "--version" option' do
        it 'should print application version and exit' do
          ARGV[0] = '--version'
          expect(fake_output).to receive(:puts).with(Mimir::VERSION)
          expect{cli.run}.to raise_error SystemExit
        end
      end
    end # run
  end
end
