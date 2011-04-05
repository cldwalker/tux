module Tux
  module Commands
    SETTINGS = %w{methodoverride inline_templates}

    def routes
      Tux.app_class.routes.inject([]) {|arr, (k,v)|
        arr += v.map {|e|
          [k, (str = e[0].inspect[%r{/\^(.*)\$/}, 1]) ? str.tr('\\', '') : e[0]]
        }
      }
    end

    def settings
      meths = (class << Tux.app_class; self; end).instance_methods(false).
        sort.map(&:to_s).select {|e| e[/=$/] }.map {|e| e[0..-2] } - SETTINGS
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

  module CommandsFormatted
    def self.format(arr)
      arr = arr.map {|e| [e[0], e[1].inspect] }
      max1 = arr.map {|e| e[0].length }.max
      max2 = arr.map {|e| e[1].length }.max
      arr.map {|k,v| "%-*s  %-*s" % [max1, k, max2, v] }
    end

    def routes
      puts CommandsFormatted.format(super)
    end

    def settings
      puts CommandsFormatted.format(super)
    end
  end
end
