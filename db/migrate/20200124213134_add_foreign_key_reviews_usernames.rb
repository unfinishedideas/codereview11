class AddForeignKeyReviewsUsernames < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :user_id, :int
    add_foreign_key :reviews, :users
  end
end
