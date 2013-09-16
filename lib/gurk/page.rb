require 'erb'
require 'tilt'

module Gurk
  class Page
    attr_accessor :name, :route, :locals, :layout

    def initialize(data)
      @name = data[:name].downcase
      @locals = data[:locals]
      @route = data[:route]
      @layout= data[:locals][:layout] if data[:locals] && data[:locals][:layout]
    end  

    def render(env)
      output = nil

      if @layout
        output = render_template_with_layout(env) do
          render_template(env)
        end
      else
        output = render_template(env)
      end

      [200, {content_type: 'text/html'}, output]

    rescue Errno::ENOENT => e
      raise Gurk::TemplateNotFound.new(e)  
    rescue RuntimeError, Exception => e
      # TODO: Make this more sensible
      raise e
    end

    def render_template_with_layout(env, &block)
      tilt = Tilt.new(layout_path)
      tilt.render(nil, locals) do
        yield
      end
    end

    def render_template(env)
      tilt = Tilt.new(view_path)
      tilt.render(nil, locals) 
    end

    def view_name
      @view_name ||= @name
    end 

    def view_path
      Gurk.view_path + '/' + view_name + '.' + Gurk.default_view_engine.to_s
    end
    
    def layout_name
      @locals[:layout]
    end

    def layout_path
      if layout_name =~ /\.(erb|haml|)/
        Gurk.view_path + '/' + layout_name
      else
        Gurk.view_path + '/' + layout_name + '.' + Gurk.default_view_engine.to_s
      end
    end

  end
end

class Gurk::TemplateNotFound < Exception; end
class Gurk::TemplateEngineNotFound < Exception; end
