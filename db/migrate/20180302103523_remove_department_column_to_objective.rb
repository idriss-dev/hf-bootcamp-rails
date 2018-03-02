class RemoveDepartmentColumnToObjective < ActiveRecord::Migration[5.1]
  def change
    remove_column :objectives, :department_id, :references, foreign_key: true
  end
end
