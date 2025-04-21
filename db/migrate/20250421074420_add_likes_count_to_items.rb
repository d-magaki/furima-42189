class AddLikesCountToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :likes_count, :integer, default: 0, null: false
  end
end