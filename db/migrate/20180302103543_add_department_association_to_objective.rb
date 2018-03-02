class AddDepartmentAssociationToObjective < ActiveRecord::Migration[5.1]
  def change
    add_reference :objectives, :department, index: true
  end
end
