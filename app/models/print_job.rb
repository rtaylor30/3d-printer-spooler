class PrintJob < ActiveRecord::Base
  belongs_to :printer
  belongs_to :assigned_by
  has_many :print_requests
  # attr_accessible :title, :body
end

