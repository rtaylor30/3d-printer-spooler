class AddOnlineAndSlugToPrinter < ActiveRecord::Migration
  def change
    change_table :printers do |t|
      t.string :slug
      t.boolean :online
    end
  end
end
