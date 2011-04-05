require 'ripl'
require 'tux/version'
require 'tux/commands'
Ripl::Commands.include Tux::CommandsFormatted, Tux::Commands

module Tux
  def self.app_class
    @app_class ||= begin
      klasses = objects(Class).select {|e| e.superclass == Sinatra::Base }
      raise "No Sinatra application found" if klasses.empty?
      klasses.size == 1 ? klasses[0] : (klasses - [Sinatra::Application])[0] 
    end
  end

  private
  def self.objects(klass)
    objs = []
    ObjectSpace.each_object(klass) {|e| objs.push(e) }
    objs
  end
end
