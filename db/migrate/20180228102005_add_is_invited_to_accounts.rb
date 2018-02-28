class AddIsInvitedToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :is_invited, :boolean
  end
end
