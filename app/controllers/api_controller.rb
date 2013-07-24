class ApiController < ApplicationController
  before_filter :check_api_key

  def update_print_request
    @print_request = PrintRequest.find(params[:id])
    # TODO : Add in different hooks of things that need to be done on update
  end
  
  def poll_new_requests
    @print_requests = PrintRequest.where(status: 'Not Ready').all
    render json: @print_requests
    PrintRequest.where(status: 'Not Ready').update_all(status: 'Delivered')
  end

  def poll_users
    @users = User.all
    render json: @users
  end

  private

    def check_api_key
      raise 'Invalid API key' if params[:key] != APP_CONFIG['api_key']
    end
end

