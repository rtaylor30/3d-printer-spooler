class AddStatusToPrintJobs < ActiveRecord::Migration
  def change
    change_table :print_jobs do |t|
      t.string :status
    end
  end
end
