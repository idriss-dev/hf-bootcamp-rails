class AddDepartmentsAssociationToAccount < ActiveRecord::Migration[5.1]
  def change
    add_reference :departments, :account, index: true
  end
end
