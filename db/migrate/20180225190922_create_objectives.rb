class CreateObjectives < ActiveRecord::Migration[5.1]
  def change
    create_table :objectives do |t|
      t.string :name
      t.string :description
      t.references :assignee, foreign_key: true
      t.date :due_date
      t.references :department, foreign_key: true
      t.integer :status
      t.decimal :progress
      t.string :milestones
      t.string :priorities

      t.timestamps
    end
  end
end
