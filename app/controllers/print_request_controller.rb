class PrintRequestController < ApplicationController

  def index
    @print_requests = PrintRequest.includes(:printer)
  end

  def update
    print_request = PrintRequest.find(params[:id])
    print_request.status = params[:print_request][:status]
    print_request.save!
    render nothing: true
  end

  def create
    file_io = params['stl_file']
    print_request = PrintRequest.new
    print_request.stl_file_name = file_io.original_filename
    timestamp = Time.now.to_s :in_file_timestamp_format 
    filename = timestamp + '_' + file_io.original_filename

    File.open(Rails.root.join('public', 'stl_files', filename), 'wb') do |file|
      file.write(file_io.read)
    end

    print_request.status = 'Not Started'
    print_request.user = current_user
    print_request.save
    redirect_to '/home'
  end
end

