require File.join(File.dirname(__FILE__), '/../', 'spec_helper')

include Rack::Test::Methods

describe Gurk::Router do

  before do
    @router = Gurk::Router.new 
  end

  it 'returns a valid instance' do
    expect(@router).to be_instance_of Gurk::Router
  end

  it 'returns a valid http_router instance' do
    expect(@router.http_router).to be_instance_of HttpRouter
  end

  context "Adding Pages" do

    it 'adds a page with a valid content' do

      page = Gurk::Page.new("about feature")
      page.parse!

      page.stub(:path).and_returns('/about')
      page.stub(:locals).and_returns({title: 'lalala'})
      page.stub(:render).and_returns('<span>lalala</span>')

      @router.add page

      request "/about"

      expect(last_response.body).to include 'lalala'      
    end

    it 'adds pages from the pages collection' do
      pending
    end

    it 'adds a page with a redirect' do
      pending
    end

    it 'adds a static route' do
      pending
    end

  end

end
