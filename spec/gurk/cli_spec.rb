require 'spec_helper'

describe Gurk::Cli do

  let(:sample_directory) {
    File.join(Dir.pwd, "spec", "support", "testapp")
  }

  before do
    FileUtils.rm_rf sample_directory

    ARGV.replace []
    ARGV << sample_directory

    cli = Gurk::Cli.new ARGV
    cli.setup
  end

  describe "#setup" do

    it 'creates the app directory' do     
      expect(File.exists?(sample_directory)).to be_true
    end

    it 'creates individual app files' do
      expect(File.exists?(File.join(sample_directory, 'config.ru'))).to be_true
      expect(File.exists?(File.join(sample_directory, 'app.rb'))).to be_true
    end

    it 'shows setup instructions' do
      pending
    end

  end

end

