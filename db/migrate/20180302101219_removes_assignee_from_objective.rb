class RemovesAssigneeFromObjective < ActiveRecord::Migration[5.1]
  def change
    remove_column :objectives, :assignee_id, :references, foreign_key: true
  end
end
