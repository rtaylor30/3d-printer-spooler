require 'json'

namespace :app do
  desc 'Update the environment by polling client server'
  task poll: :environment do
    base_uri = URI.parse( APP_CONFIG['poll_base_uri'] )

    uri = "#{base_uri}/poll_users?key=#{APP_CONFIG['api_key']}"
    response = RestClient.get uri
    users = JSON.parse( response )
    users.each do |u|
      user = User.where( id: u['id'] ).first
      if not user
        user = User.new
        user.id = u['id']
        user.password = 'dont_use_this'
      end

      user.email = u['email']
      user.save!
    end

    # Update the current print_requests
    uri = "#{base_uri}/poll_new_requests?key=#{APP_CONFIG['api_key']}"
    response = RestClient.get uri

    print_requests = JSON.parse( response )
    print_requests.each do |print_request|
      pr = PrintRequest.create( print_request )
      pr.user_id = print_request['user_id']
      pr.save!
      # Get the files associated with the print request
      RestClient.get( APP_CONFIG['poll_base_uri'] + "/stl_files/#{pr.gcode_filename}" ) { |response, request, result|
        File.open( Rails.root.join( 'public', 'stl_files', pr.gcode_filename ), 'wb' ) { |fh|
          fh.write( response )
        }
      }

      RestClient.get( APP_CONFIG['poll_base_uri'] + "/stl_files/#{pr.stl_file_name}" ) { |response, request, result|
        File.open( Rails.root.join( 'public', 'stl_files', pr.stl_file_name ), 'wb' ) { |fh|
          fh.write( response )
        }
      }
    end
  end
end

