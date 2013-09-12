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
      process_params(page)

      http_router.add(page.path).to { |env| 
          page.render env
      }
    end

    def process_params(url)
      http_router.url(url)
    end

    def routes
      @routes ||= []
    end

    def call(env)
      http_router.call(env)
    end

  end
end

