require 'http_router'

module Gurk
  class Router

    def initialize
      http_router
    end

    def http_router
      @http_router ||= HttpRouter.new
    end

    def add(page)
      routes.push(page)
      http_router.add(page.route).to { |env| 
        page.render env
      }
    end

    def routes
      @routes ||= []
    end

    def call(env)
      http_router.call(env)
    end

  end
end

