class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.references :address
      t.string :key, :null => false, :default => ''
      t.string :value

      t.timestamps
    end
    add_index :options, :address_id
    add_index :options, :key
  end
end
