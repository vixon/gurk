require "gurk/version"
require "gurk/router"
require "gurk/parser"
require "gurk/page"
require "tilt"
require "tilt/erb"

module Gurk

  Tilt.register Tilt::ERBTemplate, '.html.erb'

  def self.root
    Dir.pwd
  end

  # The default template
  @@default_view_engine = :erb

  def self.default_view_engine
    @@default_view_engine
  end

  def self.default_view_engine=(new_default_view_engine)
    @@default_view_engine = new_default_view_engine
  end

  # The default view path
  @@view_path = self.root + "/app/views"

  def self.view_path
    @@view_path 
  end

  def self.view_path=(new_view_path)
    @@view_path = new_view_path
  end

  @@feature_paths = Dir.glob("#{Dir.pwd}/features/*.feature")

  def self.feature_paths
    @@feature_paths   
  end

  def self.feature_paths=(new_feature_path)
    @@feature_paths = new_feature_path
  end

  @@router ||= Gurk::Router.new

  def self.router
    @@router
  end

  def self.run
    puts self.feature_paths
    parsed = Gurk::Parser.new(self.feature_paths).parse!

    parsed.each do |p|
      router.add Gurk::Page.new(p)
    end

    self.router
  end

end
