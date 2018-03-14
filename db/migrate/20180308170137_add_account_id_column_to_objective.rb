class AddAccountIdColumnToObjective < ActiveRecord::Migration[5.1]
  def change
    add_column :objectives, :account_id, :integer
  end
end
