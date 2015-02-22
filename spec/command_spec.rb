require 'spec_helper'

module Mimir
  describe Command do
    describe '#new' do
      context 'without arguments' do
        it 'should complain about number of arguments' do
          expect {Mimir::Command.new}.to raise_error ArgumentError
        end
      end

      context 'with wrong type of argument' do
        it 'should complain about number of arguments' do
          expect {Mimir::Command.new({ })}.to raise_error ArgumentError
          expect {Mimir::Command.new(' ')}.to raise_error ArgumentError
          expect {Mimir::Command.new(100)}.to raise_error ArgumentError
          expect {Mimir::Command.new(1.0)}.to raise_error ArgumentError
        end
      end

      context 'with proper type of argument' do
        it 'should not complain at all' do
          expect {Mimir::Command.new([])}.not_to raise_error
        end
      end

      context 'with the ["dump", "Hash"] argument' do
        let(:args)  { %w(dump Hash) }
        let(:cmd)   { Mimir::Command.new(args) }

        it 'should set its attributes properly' do
          expect(cmd.command_name).to                 eq 'dump'
          expect(File.exist?(cmd.location)).to        eq true
          expect(File.exist?(cmd.usage_file_path)).to eq true
          expect(File.exist?(cmd.command_file)).to    eq true

          expect(cmd.usage_content).to    match(/Get list of all objects/)
          expect(cmd.command_options).to  eq({"dump"=>true, "<class>"=>"Hash"})
        end
      end
    end # new

    describe '#run' do
      let(:args)  { %w(dump Hash) }
      let(:cmd)   { Mimir::Command.new(args) }

      context 'with the "Array.new" argument' do
        it 'should get the result of the command and complain' do
          expect {cmd.run('Array.new')}.to raise_error(/Hash/)
        end
      end

      context 'without an argument' do
        it 'should execute the command and print results' do
          expect {cmd.run()}.to output(/Hash/).to_stdout
        end
      end
    end # run
  end
end
