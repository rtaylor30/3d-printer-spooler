class Printer < ActiveRecord::Base
  attr_accessible :address, :name, :status, :online, :slug
end
