class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :name
      t.string :email
      t.string :company
      t.string :twitter
      t.string :facebook
      t.text :content
      t.boolean :situation, :default => false
      t.references :post

      t.timestamps
    end
    add_index :comments, :post_id
  end
end
