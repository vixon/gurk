require 'thor'
require 'gurk/cli'

module Gurk

  class Runner < Thor

    map "-T" => :list, "-i" => :install, "-u" => :update, "-v" => :version

    desc "new app_name", "Generates a new Gurk application"
    method_options :as => :string, :relative => :boolean, :force => :boolean
    def new(name)
      Gurk::Cli.new([name]).setup
      say "New Gurk app generated. Now start Gurkin!"
    end

    desc "version", "Show Gurk version"
    def version
      require 'thor/version'
      say "Gurk #{Gurk::VERSION}"
    end

  end

end
