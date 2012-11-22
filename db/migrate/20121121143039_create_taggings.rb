class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.references :tag, :null => false
      t.references :address, :null => false

      t.timestamps
    end
    add_index :taggings, :tag_id
    add_index :taggings, :address_id
  end
end
