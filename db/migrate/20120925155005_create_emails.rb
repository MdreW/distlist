class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.references :campaign, :null => false
      t.string :subject, :null => false, :default => ''
      t.text :body
      t.boolean :sended, :default => false
      t.string :key_required, :null => false, :default => ''
      t.string :tag_required, :null => false, :default => ''

      t.timestamps
    end
    add_index :emails, :campaign_id
    add_index :emails, :sended
  end
end
