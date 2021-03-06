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

      context 'with proper option' do
        let(:options) { Mimir::Options.new(usage, {argv: '--fix'}) }
        it 'should parse all the options and arguments' do
          options.parse
          expect(options.result).to eq({'--fix' => true})
        end
      end

      context 'with not recognized option' do
        let(:options) { Mimir::Options.new(usage, {argv: '--ask'}) }
        it 'should print usage and exit' do
          expect {options.parse}.to (output(/Usage:/).to_stdout).and raise_exception SystemExit
        end
      end
    end # parse

    describe '#skip_false_options' do
      let(:usage)   { "Usage: mimir -q | -s" }
      let(:options) { Mimir::Options.new(usage, {argv: '-q'}) }

      it 'should remove false options' do
        options.parse
        options.skip_false_options
        expect(options.result).to eq({'-q' => true})
      end
    end # skip_false_options

    describe '#skip_empty_arguments' do
      let(:usage)   { "Usage: mimir -f [<var>]" }
      let(:options) { Mimir::Options.new(usage, {argv: '-f'}) }

      it 'should remove empty arguments' do
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
