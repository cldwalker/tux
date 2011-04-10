module Tux
  module Commands
    SETTINGS = %w{methodoverride inline_templates}

    def routes
      Tux.app_class.routes.inject([]) {|arr, (k,v)|
        arr += v.map {|regex,params,*|
          path = params.empty? ? regex.inspect :
            params.inject(regex.inspect) {|s,e| s.sub(/\([^()]+\)/, ":#{e}") }
          [k, (str = path[%r{/\^(.*)\$/}, 1]) ? str.tr('\\', '') : path]
        }
      }
    end

    def settings
      meths = (Tux.app_class.methods(false) + Sinatra::Base.methods(false)).
        sort.map(&:to_s).select {|e| e[/=$/] }.map {|e| e[0..-2] } - SETTINGS
      meths.map {|meth| [meth, (Tux.app_class.send(meth) rescue $!.inspect)] }
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
