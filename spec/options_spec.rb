require 'spec_helper'

module Mimir
  describe Options do
    describe '#new' do
      let(:usage)   { "Usage: mimir [--help] | [--version]" }
      let(:options) { Mimir::Options.new(usage) }

      it 'should not return nil' do
        expect(options).not_to be nil
      end
      it 'should set attributes properly' do
        expect(options.options).to      be_an_instance_of(Hash)
        expect(options.options).not_to  be_empty
        expect(options.usage).to        be_an_instance_of(String)
        expect(options.usage).to        eq(usage)
        expect(options.result).to       be_an_instance_of(Hash).and be_empty
      end
    end # new

    describe '#parse' do
      let(:usage)   { "Usage: mimir --fix" }
      let(:options) { Mimir::Options.new(usage) }

      context 'with proper option' do
        it 'should parse all the options and arguments' do
          ARGV[0] = '--fix'
          options.parse
          expect(options.result).to eq({'--fix' => true})
        end
      end

      context 'with not recognized option' do
        it 'should print usage and exit' do
          ARGV[0] = '--ask'
          expect {options.parse}.to (output(/Usage:/).to_stdout).and raise_exception SystemExit
        end
      end
    end # parse

    describe '#skip_false_options' do
      let(:usage)   { "Usage: mimir -q | -s" }
      let(:options) { Mimir::Options.new(usage) }

      it 'should remove false options' do
        ARGV[0] = '-q'
        options.parse
        options.skip_false_options
        expect(options.result).to eq({'-q' => true})
      end
    end # skip_false_options

    describe '#skip_empty_arguments' do
      let(:usage)   { "Usage: mimir -f [<var>]" }
      let(:options) { Mimir::Options.new(usage) }

      it 'should remove empty arguments' do
        ARGV[0] = '-f'
        options.parse
        options.skip_false_options
        expect(options.result).to eq({'-f' => true})
      end
    end # skip_empty_arguments

    describe '::get_option' do
      it 'should return option value, if exists' do
        opts  = {'free' => 'bird'}
        opt   = 'free'
        expect(Mimir::Options::get_option(opts, opt)).to eq('bird')
      end
    end # skip_empty_arguments

  end
end
