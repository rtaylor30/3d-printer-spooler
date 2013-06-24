class AddUserToPrintRequests < ActiveRecord::Migration
  def change
    change_table :print_requests do |t|
      t.references :user
    end
  end
end
