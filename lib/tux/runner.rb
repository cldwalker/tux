module Tux
  class Runner < Ripl::Runner
    self.app = 'tux'
    add_options ['-c, --config FILE', 'Set rack config file i.e. config.ru']

    def self.parse_option(option, argv)
      if option[/(?:-c|--config)=?(.*)/]
        ENV['RACK_CONFIG'] = $1.empty? ? argv.shift.to_s : $1
      else
        super
      end
    end
  end
end
