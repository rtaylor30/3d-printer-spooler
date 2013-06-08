class PrintRequest < ActiveRecord::Base
  belongs_to :printer
  belongs_to :print_job
  attr_accessible :status, :stl_file_name, :created_at
end

