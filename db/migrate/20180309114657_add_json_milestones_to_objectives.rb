class AddJsonMilestonesToObjectives < ActiveRecord::Migration[5.1]
  def change
    add_column :objectives, :json_milestones, :jsonb, default: '{}'
  end
end
