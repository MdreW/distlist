class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.references :email, :null => false
      t.string :atype, :null => false, :default => 'attached'

      t.timestamps
    end
    add_attachment :attachments, :file
    add_index :attachments, :email_id
    add_index :attachments, :atype
  end
end
