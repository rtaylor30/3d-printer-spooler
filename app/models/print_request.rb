class PrintRequest < ActiveRecord::Base
  belongs_to :printer
  belongs_to :print_job
  attr_accessible :status, :stl_file_name, :created_at
  
  after_commit :check_status_completed

  private

  def check_status_completed
    if status == 'success'
      PrintRequestStatusMailer.status_email(@user, self).deliver
    end
  end

end

