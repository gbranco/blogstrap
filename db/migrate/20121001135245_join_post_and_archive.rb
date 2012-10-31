class JoinPostAndArchive < ActiveRecord::Migration
  def up
  	create_table :archives_posts, :id => false do |t|
    	t.references :archive 
    	t.references :post
  	end
  end

  def down
  	drop_table :archives_posts
  end
end
