class AddDefaultValueForStatusToObjective < ActiveRecord::Migration[5.1]
  def change
    change_column :objectives, :status, :integer, default: 0
  end
end
