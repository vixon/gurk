require "gurk/version"
require "gurk/router"
require "gurk/parser"
require "gurk/page"

module Gurk
  def self.root
    File.expand_path '../..', __FILE__
  end

  @@router = Gurk::Router.new


  def self.router
    @@router
  end

  def self.run
    sources = Dir.glob("#{Gurk.root}/**/*.feature")
    parsed = Gurk::Parser.new(sources).parse!

    parsed.each do |p|
      @@router.add Gurk::Page.new(p)
    end
  end

end
