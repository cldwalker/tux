require 'bacon'
require 'bacon/bits'
require 'tux'
require 'sinatra/base'

class TestApp < Sinatra::Base
  helpers do
    def moo(str)
      "moo-#{str}"
    end
  end

  set :root, 'dir'
  set :ka, lambda { raise 'boom' }

  get '/' do end

  post '/:id/:format' do end
end
