require 'rack/test'
require File.join(File.dirname(__FILE__), '/../example/app.rb')

include Rack::Test::Methods

describe 'Gurk::Example' do

  before do
    Gurk.stub(:view_path).and_return File.join('spec', 'example', 'app', 'views')
    Gurk.stub(:feature_paths).and_return Dir.glob("#{Dir.pwd}/spec/example/features/*.feature")

    request '/'
  end

  def app
    Gurk.run
  end

  it 'returns homepage successfully' do
    expect(last_response.status).to eq(200)
  end

  it 'shows the title' do
    expect(last_response.body).to include ('home')
  end

end
