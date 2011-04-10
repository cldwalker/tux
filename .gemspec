# -*- encoding: utf-8 -*-
require 'rubygems' unless Object.const_defined?(:Gem)
require File.dirname(__FILE__) + "/lib/tux/version"

Gem::Specification.new do |s|
  s.name        = "tux"
  s.version     = Tux::VERSION
  s.authors     = ["Gabriel Horner"]
  s.email       = "gabriel.horner@gmail.com"
  s.homepage    = "http://github.com/cldwalker/tux"
  s.summary = "Sinatra dressed for interactive ruby - a sinatra shell"
  s.description =  "Tux dresses up sinatra in a shell. Use it to interact with your helpers, view rendering and your app's response objects. Tux also gives you commands to view your app's routes and settings."
  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project = 'tagaholic'
  s.executables = ['tux']
  s.add_dependency 'ripl', '>= 0.3.5'
  s.add_dependency 'ripl-rack', '>= 0.2.0'
  s.add_dependency 'ripl-multi_line', '>= 0.2.4'
  s.add_dependency 'sinatra', '>= 1.2.1'
  s.add_development_dependency 'bacon', '>= 1.1.0'
  s.add_development_dependency 'bacon-bits', '>= 0.1.0'
  s.files = Dir.glob(%w[{lib,test}/**/*.rb bin/* [A-Z]*.{txt,rdoc} ext/**/*.{rb,c} **/deps.rip]) + %w{Rakefile .gemspec}
  s.extra_rdoc_files = ["README.rdoc", "LICENSE.txt"]
  s.license = 'MIT'
end
