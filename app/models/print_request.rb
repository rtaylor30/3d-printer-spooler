class PrintRequest < ActiveRecord::Base
  belongs_to :printer
  belongs_to :print_job
  belongs_to :user
  attr_accessible :id, :status, :stl_file_name, :created_at, :gcode_filename
  
  after_commit :check_status_completed

  private

  def check_status_completed
    if status == 'success'
      PrintRequestStatusMailer.status_email(@user, self).deliver
    end
  end

end

