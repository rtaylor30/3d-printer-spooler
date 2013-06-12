class PrintJobController < ApplicationController
  def index
    @print_jobs = PrintJob.all
  end

  def show
    @print_job = PrintJob.find(params[:id])
    @print_requests = PrintRequest.all
    @printers = Printer.all
  end

  def update
    form = params[:print_job]
    @print_job = PrintJob.find(params[:id])
    @print_job.printer = Printer.find(form[:printer])
    @print_job.print_requests = PrintRequest.find(params[:print_requests]) 
    @print_job.status = form[:status]
    @print_job.save!
    redirect_to action: :index
  end
end

