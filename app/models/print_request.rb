class PrintRequest < ActiveRecord::Base
  belongs_to :printer
  attr_accessible :status, :stl_file_name, :created_at
end

