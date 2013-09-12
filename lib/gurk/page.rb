module Gurk
  class Page

    attr_accessor :name, :path, :locals

    def initialize(data)
      @name = data[:name]
      @locals = data[:locals]
      @path = data[:route]
    end  

    def render
      # TiltIt.
    end

  end
end
