class CreatePrintJobs < ActiveRecord::Migration
  def change
    create_table :print_jobs do |t|
      t.references :printer
      t.references :assigned_by

      t.timestamps
    end
    add_index :print_jobs, :printer_id
    add_index :print_jobs, :assigned_by_id
  end
end
