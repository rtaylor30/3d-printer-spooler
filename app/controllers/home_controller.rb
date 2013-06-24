class HomeController < ApplicationController
  before_filter :authenticate_user!, only: :index

  def index
    @print_requests = current_user.print_requests
    @print_requests = @print_requests.sort_by do |pr|
      pr.updated_at
    end
    @last_updated_dt = @print_requests.last.updated_at
  end

  def root
    if current_user.nil?
      render 'home/root'
    else
      index
      render 'home/index'
    end
  end
end

