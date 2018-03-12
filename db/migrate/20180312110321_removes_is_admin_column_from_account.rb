class RemovesIsAdminColumnFromAccount < ActiveRecord::Migration[5.1]
  def change
    remove_column :accounts, :is_admin, :boolean
  end
end
