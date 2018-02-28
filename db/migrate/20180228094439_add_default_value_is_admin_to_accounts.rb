class AddDefaultValueIsAdminToAccounts < ActiveRecord::Migration[5.1]
  def change
    change_column :accounts, :is_admin, :boolean, default:  false
  end
end
