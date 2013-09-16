require 'spec_helper'

describe Gurk::Cli do

  before do
    cli = Gurk::Cli.new
    cli.setup
    # cleanup output directory
  end

  describe "#setup" do

    it 'creates the app directory and subdirectories' do
      pending
    end

    it 'creates the config.ru' do
      pending
    end

    it 'creates the app.rb' do
      pending     
    end

    it 'shows setup instructions' do
      pending
    end

  end

end

