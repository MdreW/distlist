class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.references :user, :null => false
      t.string :title, :null => false, :default => ""
      t.text :header
      t.text :footer
      t.string :sender_name
      t.string :sender_email, :null => false, :default => ""
      t.integer :time_gap, :null => false, :default => 0

      t.timestamps
    end
    add_index :campaigns, :user_id
  end
end
