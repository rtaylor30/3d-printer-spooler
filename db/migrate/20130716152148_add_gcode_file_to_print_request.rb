class AddGcodeFileToPrintRequest < ActiveRecord::Migration
  def change
    change_table :print_requests do |t|
      t.string :gcode_filename
    end
  end
end
