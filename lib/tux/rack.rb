require 'ripl/rack'
Ripl.config[:rackit] = true
Ripl::Rack::App::MESSAGE.replace "No Sinatra application found. Specify the app's config file with tux -c."
