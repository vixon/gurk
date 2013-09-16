require 'spec_helper'

describe Gurk::Page do

  describe '#pages' do

    Gurk.view_path = File.join(Dir.pwd, 'spec', 'support', 'views')

    let(:page) { 
      Gurk::Page.new({name: 'about', path: '/pages/slug', locals: {title: 'lalala'}})
    }

    it 'returns the view name' do
      expect(page.view_name).to eq('about')
    end

    context "nolayout" do
      it 'returns the layout name' do
        expect(page.layout_name).to be_nil
      end
    end

    context "with a layout" do
      it 'returns the layout name' do
        page.locals.merge!(layout: 'wat')
        expect(page.layout_name).to eq 'wat'
      end
    end
  end

  describe '#render' do

    it 'render the page' do
      page = Gurk::Page.new({name: 'about', path: '/pages/slug', locals: {title: 'lalala'}})
      result = page.render nil
      expect(result.last).to include 'lalala'
    end

    it 'renders the page with the layout' do
      page = Gurk::Page.new({name: 'about', path: '/pages/slug', locals: {title: 'lalala', layout: 'layout.erb'}})
      result = page.render nil

      expect(result.last).to include 'This is the layout'
      expect(result.last).to include 'lalala'
    end

    it 'raises an exception if the template is invalid' do
      page = Gurk::Page.new({name: 'aboutlalala', path: '/pages/slug', locals: {title: 'lalala'}})
      expect {
        page.render nil
      }.to raise_exception(Gurk::TemplateNotFound)
    end

  end

end
