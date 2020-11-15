class RenameNameToUserNameOrders < ActiveRecord::Migration[6.0]
  def change
    rename_column :orders, :name, :user_name
  end
end
