class AddDepartmentIdToObjectives < ActiveRecord::Migration[5.1]
  def change
    add_reference :objectives, :department, foreign_key: true
  end
end
