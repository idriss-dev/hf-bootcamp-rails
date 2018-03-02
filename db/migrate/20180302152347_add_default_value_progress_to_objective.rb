class AddDefaultValueProgressToObjective < ActiveRecord::Migration[5.1]
  def change
    change_column :objectives, :progress, :decimal, default: 0
  end
end
