class CreatePrintRequests < ActiveRecord::Migration
  def change
    create_table :print_requests do |t|
      t.string :stl_file_name
      t.string :status
      t.references :printer

      t.timestamps
    end
    add_index :print_requests, :printer_id
  end
end
