require 'spec_helper'

describe Gurk::Parser do

  let(:parsed_data) do
    [ 
      { :name => "About", :route => "/about", :locals => [ { :title=>"about" } ] },
      { :name => "Home", :route => "/", :locals => [ { :title => "home" } ] } 
    ]
  end

  let(:steps) do
     [ ["I have a page called 'About'",
     "it has a title called 'about'",
     "it has a route of '/about'",
     "I visit '/about'",
     "I should see 'about'",],
     ["I have a page called 'Home'",
     "it has a title called 'home'",
     "it has a route of '/'",
     "I visit '/'",
     "I should see 'home'"] ]
  end

  let(:parsed_steps) do
    [ {"keyword"=>"Given ", "name"=>"I have a page called 'About'", "line"=>4},
      {"keyword"=>"And ", "name"=>"it has a title called 'about'", "line"=>5},
      {"keyword"=>"And ", "name"=>"it has a route of '/about'", "line"=>6},
      {"keyword"=>"When ", "name"=>"I visit '/about'", "line"=>7},
      {"keyword"=>"Then ", "name"=>"I should see 'about'", "line"=>8}]
    [ {"keyword"=>"Given ", "name"=>"I have a page called 'Home'", "line"=>4},
      {"keyword"=>"And ", "name"=>"it has a title called 'home'", "line"=>5},
      {"keyword"=>"And ", "name"=>"it has a route of '/'", "line"=>6},
      {"keyword"=>"When ", "name"=>"I visit '/'", "line"=>7},
      {"keyword"=>"Then ", "name"=>"I should see 'home'", "line"=>8}]
  end

  let(:parsed_names) do
    [ ["I have a page called 'About'",
       "it has a title called 'about'",
       "it has a route of '/about'",
       "I visit '/about'",
       "I should see 'about'"],
       ["I have a page called 'Home'",
        "it has a title called 'home'",
        "it has a route of '/'",
        "I visit '/'",
        "I should see 'home'"] ]
  end

  describe '#initialize' do
    it 'reads existing feature files' do
      Gurk::Parser.any_instance.should_receive(:read_feature_files)
      Gurk::Parser.new
    end
  end

  describe '#parse!' do
    it 'parses each set of names extracted from the feature files' do
      Gurk::Parser
        .any_instance
        .should_receive(:parse_names)
        .exactly(parsed_names.length)
        .times
      Gurk::Parser.new.parse!
    end

    it 'passes the parsed data to #parse_locals' do
      parser = Gurk::Parser.new
      Gurk::Parser
        .any_instance
        .should_receive(:parse_locals)
        .with(parser.instance_variable_get :@parsed_data)
      parser.parse!
    end

    it 'returns a hash with the correct format' do
      expect(Gurk::Parser.new.parse!).to eq parsed_data
    end
  end

  describe 'private methods' do
    let(:parser) { Gurk::Parser.new }

    describe '#read_feature_files' do
      it 'parses the feature files' do
        Gherkin::Parser::Parser
          .any_instance
          .should_receive(:parse)
          .exactly(parsed_names.length)
          .times
        Gurk::Parser.new
      end

      it 'passes the result to #process_data' do
        Gurk::Parser.any_instance.should_receive(:process_data)
        Gurk::Parser.new
      end
    end

    describe '#process_data' do
      it 'finds all "elements" nodes in the given data and passes it to #extract_steps_from' do
        Gurk::Parser
          .any_instance
          .should_receive(:extract_steps_from)
          .twice # Two 'element' nodes
        Gurk::Parser.new
      end
    end

    describe '#extract_steps_from' do
      it 'finds all "steps" nodes in the given data and passes it to #extract_names_from' do
        Gurk::Parser
          .any_instance
          .should_receive(:extract_names_from)
          .twice # Two 'steps' nodes
        Gurk::Parser.new
      end

      it 'saves the return value of #extract_names_from' do
        expect(parser.instance_variable_get :@parsed_names).to eq parsed_names
      end
    end

    describe '#extract_names_from' do
      it 'finds and returns all "name" nodes from the given data' do
        expect(parser.send(:extract_names_from, parsed_steps)).to eq parsed_names.last
      end
    end

    describe '#parse_names' do
      it 'passes the given data to #parse_steps' do
        Gurk::Parser
          .any_instance
          .should_receive(:parse_names)
          .exactly(parsed_names.length)
          .times
        Gurk::Parser.new.parse!
      end
    end

    describe '#parse_steps' do
      context 'with a matching step' do
        it 'returns the parsed step' do
          expect(parser.send(:parse_steps, "I have a page called 'About'")).to include name: 'About'
        end
      end

      context 'with a non-matching step' do
        it 'returns an array of nils' do
          expect(parser.send(:parse_steps, "I visit '/about'")).to eq [nil, nil, nil]
        end
      end
    end

    describe '#parse_locals' do
      it 'passes each given step to #sanitize' do
        step = [[{:name=>"About"}, {:title=>"about"}, {:route=>"/about"}]]
        parser.stub(:extract_locals_from)
        parser.should_receive(:sanitize)
        parser.send :parse_locals, step
      end

      it 'passes sanitized steps to #extract_locals_from' do
        step = [[{:name=>"About"}, {:title=>"about"}, {:route=>"/about"}]]
        parser.should_receive(:extract_locals_from)
        parser.send :parse_locals, step
      end

      it 'returns the result of the parsing' do
        step = [[{:name=>"About"}, {:title=>"about"}, {:route=>"/about"}]]
        result = [[{:name=>"About"}, {:route=>"/about"}, {:locals=>[{:title=>"about"}]}]]
        parser.instance_variable_set(:@parsed_data, step)
        expect(parser.send :parse_locals, step).to eq result
      end
    end

    describe '#sanitize' do
      it 'returns local variable pairs' do
        step = [{:name=>"About"}, {:title=>"about"}, {:route=>"/about"}]
        expect(parser.send :sanitize, step).to eq [{:title=>"about"}]
      end
    end

    describe '#extract_locals_from' do
      it 'returns ' do
        step = [[{:name=>"About"}, {:title=>"about"}, {:route=>"/about"}]]
        local = [{:title=>"about"}]
        expect(parser.send :extract_locals_from, step, local).to eq local
      end
    end
  end
end
