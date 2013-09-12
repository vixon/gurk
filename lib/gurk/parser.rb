require 'gherkin/parser/parser'
require 'gherkin/formatter/json_formatter'
require 'stringio'
require 'multi_json'

module Gurk
  class Parser
    VALID_STEPS = [
      { "^I have a page called '(.+)'$" => lambda { |k, _| { name: k } } },
      { "^it has a route of '(.+)'$" => lambda { |k, _| { route: k } } },
      { "^it has a (.+) called '(.+)'$" => lambda { |k, v| { k.to_sym => v } } }
    ]

    def initialize(sources = Dir.glob("#{Gurk.root}/**/*.feature"))
      @parsed_names = []
      @parsed_data = []
      io = StringIO.new
      formatter = Gherkin::Formatter::JSONFormatter.new(io)
      parser = Gherkin::Parser::Parser.new(formatter)
      read_feature_files(io, parser, formatter, sources)
    end

    def parse!
      @parsed_names.each { |name| parse_names(name) }
      parse_locals(@parsed_data)
    end

  private

    def read_feature_files(io, parser, formatter, sources)
      sources.each { |s| parser.parse(IO.read(s), s, 0) }
      formatter.done
      process_data(MultiJson.load(io.string))
    end

    def process_data(data)
      data.each { |feature| extract_steps_from feature['elements'] }
    end

    def extract_steps_from(element_nodes)
      element_nodes.each { |element_node| @parsed_names << extract_names_from(element_node['steps']) }
    end

    def extract_names_from(steps)
      [].tap { |name| steps.each { |step| name << step['name'] } }
    end

    def parse_names(name)
      @parsed_data << name.map { |match| parse_steps(match) }.flatten.compact
    end

    def parse_steps(match)
      VALID_STEPS.map { |step| step.values.first.call($1, $2) if /#{step.keys.first}/ =~ match }
    end

    def parse_locals(steps)
      steps.each do |step|
        locals = sanitize(step)
        step << { locals: extract_locals_from(step, locals) }
      end
      @parsed_data
    end

    def sanitize(step)
      step.dup.reject! { |h| h.key?(:route) || h.key?(:name) }
    end

    def extract_locals_from(step, locals)
      step.reject! { |h| h == locals.first }
      locals
    end
  end
end
