class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.references :email, :null => false
      t.integer :email_count, :null => false
      t.integer :row_count

      t.timestamps
    end
    add_index :logs, :email_id
  end
end
