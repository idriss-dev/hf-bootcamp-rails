class RenameIsInviteColumnNameToInvited < ActiveRecord::Migration[5.1]
  def change
    rename_column :accounts, :is_invited, :invited
  end
end
