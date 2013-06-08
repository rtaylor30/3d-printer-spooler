class PrintRequestController < ApplicationController

  def index
    @print_requests = PrintRequest.includes(:printer)
  end

  def create
    file_io = params['stl_file']
    print_request = PrintRequest.new
    print_request.stl_file_name = file_io.original_filename
    File.open(Rails.root.join('public', 'stl_files', file_io.original_filename), 'w') do |file|
      file.write(file_io.read)
    end

    print_request.save
  end
end

