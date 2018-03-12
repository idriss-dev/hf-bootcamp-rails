class AddObjectiveAssociationToObjective < ActiveRecord::Migration[5.1]
  def change
    add_reference :objectives, :objective, index: true
  end
end
