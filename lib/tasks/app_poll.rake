require 'json'

namespace :app do
  desc 'Update the environment by polling client server'
  task poll: :environment do
    base_uri = URI.parse( APP_CONFIG['poll_base_uri'] )

    # Update the current print_requests
    uri = "#{base_uri}/poll_new_requests?key=#{APP_CONFIG['api_key']}"
    response = RestClient.get uri

    print_requests = JSON.parse( response )
    print_requests.each do |print_request|
      PrintRequest.create( print_request )
    end
  end
end
