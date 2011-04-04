require 'ripl'

module Tux
  module Commands
    def routes
      Tux.app_class.routes.inject([]) {|arr, (k,v)|
        arr += v.map {|e|
          [ k, (str = e[0].inspect[%r{/\^(.*)\$/}, 1]) ? str.tr('\\', '') : e[0] ]
        }
      }
    end

    def settings
      meths = (class << Tux.app_class; self; end).instance_methods(false).sort.map(&:to_s).
        select {|e| e[/=$/] }.map {|e| e[0..-2] } - %w{methodoverride inline_templates}
      meths.map {|meth| [meth, Tux.app_class.send(meth)] }
    end

    def app
      @app ||= begin
        obj = Tux.app_class.new!
        obj.request = Sinatra::Request.new({})
        obj.response = Sinatra::Response.new
        obj
      end
    end
  end
end
Ripl::Commands.include Tux::Commands
