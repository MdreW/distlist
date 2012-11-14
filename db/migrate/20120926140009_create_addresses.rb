class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :campaign, :null => false, :default => ''
      t.string :email, :null => false, :default => ''
      t.string :name
      t.string :surname
      t.string :pepper, :null => false, :default => '', :limit => 25
      t.integer :fail_count, :null => false, :default => 0
      t.boolean :inactive, :default => false

      t.timestamps
    end
    add_index :addresses, :campaign_id
    add_index :addresses, :email
  end
end
