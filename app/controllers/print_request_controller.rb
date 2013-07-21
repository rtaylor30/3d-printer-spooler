require 'json'
require 'slicer'

class PrintRequestController < ApplicationController
  before_filter :validate_can_create, only: :create

  def index
    @print_requests = PrintRequest.includes(:printer)
  end

  def update
    print_request = PrintRequest.find(params[:id])
    print_request.status = params[:print_request][:status]
    print_request.save!
    
    sync print_request if ENV['ADMIN_PRODUCTION']

    render nothing: true
  end

  def create
    file_io = params['stl_file']
    print_request = PrintRequest.new
    timestamp = Time.now.to_s :in_file_timestamp_format 
    filename = timestamp + '_' + file_io.original_filename
    print_request.stl_file_name = filename

    File.open(Rails.root.join('public', 'stl_files', filename), 'wb') do |file|
      file.write(file_io.read)
    end

    print_request.status = 'Processing'
    print_request.user = current_user
    print_request.save
    
    ::Slicer.run_slicer print_request.id

    redirect_to '/home'
  end

  private

    def sync print_request
      base_uri = APP_CONFIG['poll_base_uri']
      uri = "#{base_uri}/update_print_request/#{print_request.id}"
      response = RestClient.post( uri, {
        'key' => APP_CONFIG['api_key'],
        'status' => print_request.status} )
    end

    def validate_can_create
      if not can? :manage, :all
        num_print_requests = PrintRequest.where(user_id: current_user.id, status: 'Not Ready').count

        if num_print_requests >= 3
          redirect_to '/home', flash: { error: 'Cannot have more than 3 requests at a time' }
        end
      end
    end
end

