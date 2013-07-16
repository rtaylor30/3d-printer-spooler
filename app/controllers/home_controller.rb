class HomeController < ApplicationController
  before_filter :authenticate_user!, only: :index

  def index
    if current_user.admin?
      @print_requests = PrintRequest.all
    else
      @print_requests = current_user.print_requests
    end

    if @print_requests.size > 0
      @print_requests = @print_requests.sort_by do |pr|
        pr.updated_at
      end

      @last_updated_dt = @print_requests.last.updated_at
    else
      @last_updated_dt = Time.now
    end
  end

  def root
    if current_user.nil?
      render 'home/root'
    else
      index
      render 'home/index'
    end
  end

  def poll_jobs
    @jobs = PrintRequest.where(status: 'Not Ready')
    
    # This automatically assumes that the poller properly recieved the jobs. Another mechanism
    # should send another post to indicate that the jobs were properly printed.
    @jobs.each { |job|
      job.status = 'Delivered'
      job.save!
    }

    render json: @jobs
  end
end

