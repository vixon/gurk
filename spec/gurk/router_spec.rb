require File.join(File.dirname(__FILE__), '/../', 'spec_helper')

include Rack::Test::Methods

describe Gurk::Router do

  before do
    @router = Gurk::Router.new
  end

  def app
    @router
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

      page.stub(:name).and_return(:about)
      page.stub(:path).and_return('/about')
      page.stub(:locals).and_return({title: 'lalala'})
      page.stub(:render).and_return([200, {}, '<span>lalala</span>'])

      @router.add page

      request "/about"

      expect(last_response.body).to include 'lalala'      
    end

    it 'adds a page with a valid content with params' do

      page = Gurk::Page.new("feature page with parameter")

      page.stub(:name).and_return(:about)
      page.stub(:path).and_return('/pages/:slug')
      page.stub(:locals).and_return({title: 'lalala'})
      page.stub(:render).and_return([200, {}, '<span>lalala</span><span>this-is-a-slug</span>'])

      @router.add page

      request '/pages/this-is-a-slug'

      expect(last_response.body).to include 'this-is-a-slug'
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
