class RemoveUniqueIndexesFromUsers < ActiveRecord::Migration[7.1]
  def change
    # first_name のユニークインデックスを削除し、非ユニークインデックスを追加
    remove_index :users, name: "index_users_on_first_name"
    add_index :users, :first_name

    # email のユニークインデックスを削除し、非ユニークインデックスを追加
    remove_index :users, name: "index_users_on_email"
    add_index :users, :email
  end
end