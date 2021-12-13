class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text
      t.string :comments_counter
      t.string :likes_counter

      t.timestamps
    end
  end
end