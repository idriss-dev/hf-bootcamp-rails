class AddChangeColumnPrioritiesIntegerToObjectives < ActiveRecord::Migration[5.1]
  def change
    change_column :objectives, :priorities, 'integer USING CAST(priorities AS integer)'
  end
end
