class AddChangeColumnMilestonensArrayToObjectives < ActiveRecord::Migration[5.1]
  def change
    change_column :objectives, :milestones, "varchar[] USING (string_to_array(milestones, ','))"
  end
end
