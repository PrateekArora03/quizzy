class AddRoleColumnToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :role, :string, default: "regular_user", null: false
  end
end
