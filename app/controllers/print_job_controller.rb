class PrintJobController < ApplicationController
  def index
    @print_jobs = PrintJob.all
  end

  def show
    @print_job = PrintJob.find(params[:id])
  end

  def update
    @print_job = PrintJob.find(params[:id])
    @print_job.printer = Printer.find(params[:print_job][:printer])
    @print_job.save!
  end
end

