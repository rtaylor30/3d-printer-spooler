class ApiController < ApplicationController
  before_filter :check_api_key

  def update_print_request
    @print_request = PrintRequest.find(params[:id])
    # TODO : Add in different hooks of things that need to be done on update
  end
  
  def poll_new_requests
    @print_requests = PrintRequest.where(status: 'Not Ready')
    @print_requests.update_all(status: 'Delivered')
    render json: @print_requests
  end

  private

    def check_api_key
      raise 'Invalid API key' if params[:key] != '4ty7asdfjv7ty241itbnav2153'
    end
end

