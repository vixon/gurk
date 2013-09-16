require 'spec_helper'

include Rack::Test::Methods

describe Gurk do

  describe '#run' do

    before do
      Gurk.stub(:feature_paths).and_return  Dir.glob("#{Dir.pwd}/spec/support/*.feature")
      Gurk.run
    end

    it 'creates routes from the array' do
      expect(Gurk.router.routes.length).to_not be_zero
    end

  end

end


