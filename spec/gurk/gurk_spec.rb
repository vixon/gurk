require 'spec_helper'

describe Gurk do

  describe '#parser' do

    describe '#parse' do

      let(:source) { Dir.glob("#{Gurk.root}/**/*.feature") }
      let(:parsed_data) { Gurk::Parser.new(source).parse! }

      it 'returns an array of gurk parser object' do
        expect(parsed_data).to be_instance_of(Array)
      end

      it 'creates routes from the array' do
        Gurk.run
        expect(Gurk.router.routes.length).to_not be_zero
      end

      it 'creates an array of pages from the gurk parser' do
        pending
      end

    end

  end

  describe '#run' do
    before do

    end

    it 'renders the pages' do

    end
  end

end


