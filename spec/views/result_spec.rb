require 'spec_helper'

module Mimir
  # describe Views::Result do
  describe Views::Result do
    describe '#new' do
      shared_examples 'a good boy' do
        it 'does not complain at all' do
          expect {Views::Result.new}.not_to raise_error
        end
      end

      context 'without arguments' do
        it_behaves_like 'a good boy'
        it 'sets its attributes properly' do
          r = Views::Result.new
          expect(r.instance_variable_get('@options')).to \
                                eq({"--format"=>"plain", "--pretty"=>"false"})
        end
      end

      context 'with wrong type of argument' do
        it 'should complain about number of arguments' do
          expect {Views::Result.new([ ])}.to raise_error ArgumentError
          expect {Views::Result.new(' ')}.to raise_error ArgumentError
          expect {Views::Result.new(100)}.to raise_error ArgumentError
          expect {Views::Result.new(1.0)}.to raise_error ArgumentError
        end
      end

      context 'with wrong number of arguments' do
        it 'should complain about number of arguments' do
          expect {Views::Result.new({}, 1)}.to \
                        raise_error(ArgumentError, /wrong number of arguments/)
        end
      end

      context 'with proper argument' do
        let(:args)  { {'--format'=>'json'} }

        it_behaves_like 'a good boy'
        it 'sets its attributes properly' do
          r = Views::Result.new(args)
          options   = r.instance_variable_get('@options')
          renderer  = r.instance_variable_get('@renderer')

          expect(options).to  eq({"--format"=>"json", "--pretty"=>"false"})
          expect(renderer).to be_instance_of(Views::JsonView)
        end
      end
    end # new

    describe '#render' do
      it 'should try to render' do
        r = Views::Result.new
        d = double()
        r.instance_variable_set('@renderer', d)

        expect(d).to receive(:render)
        r.render
      end
    end # render
  end
end
