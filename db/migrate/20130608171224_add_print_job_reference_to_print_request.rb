class AddPrintJobReferenceToPrintRequest < ActiveRecord::Migration
  def change
    change_table :print_requests do |t|
      t.references :print_job
    end
  end
end

