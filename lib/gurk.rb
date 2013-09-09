require "gurk/version"

module Gurk
  def self.root_path
    File.expand_path '../..', __FILE__
  end
end
