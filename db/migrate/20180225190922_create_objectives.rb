class CreateObjectives < ActiveRecord::Migration[5.1]
  def change
    create_table :objectives do |t|
      t.string :name
      t.string :description
      t.date :due_date
      t.integer :status
      t.decimal :progress
      t.string :milestones
      t.string :priorities

      t.timestamps
    end
  end
end
