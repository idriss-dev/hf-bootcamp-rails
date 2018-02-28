class AddDefaultValueIsInvitedToAccounts < ActiveRecord::Migration[5.1]
  def change
    change_column :accounts, :is_invited, :boolean, default: false
  end
end
