require 'thor'
module Gurk
  class Cli < Thor::Group
    include Thor::Actions

    argument :name
   
    def self.source_root
      File.dirname(__FILE__) 
    end

    def setup
      directory "../templates", name, recursive: true
    end

    def bundle_install
      system("cd #{name} && bundle install")
    end

  end
end
