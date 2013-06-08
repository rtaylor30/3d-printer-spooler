class PrintJobController < ApplicationController
  def index
    @print_jobs = PrintJob.all
  end

  def show
    @print_job = PrintJob.find(params[:id])
    @print_requests = PrintRequest.all
  end

  def update
    @print_job = PrintJob.find(params[:id])
    @print_job.printer = Printer.find(params[:print_job][:printer])
    @print_job.print_requests = PrintRequest.find(params[:print_requests]) 
    @print_job.save!
    redirect_to action: :index
  end
end

