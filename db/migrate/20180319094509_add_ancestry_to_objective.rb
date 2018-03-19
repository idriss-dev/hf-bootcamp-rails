class AddAncestryToObjective < ActiveRecord::Migration[5.1]
  def change
    add_column :objectives, :ancestry, :string
    add_index :objectives, :ancestry
  end
end
