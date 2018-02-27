class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :email
      t.string :password
      t.string :password_confirmation
      t.string :password_digest
      t.boolean :is_admin, :default => false
      t.string :full_name
      t.timestamps
    end
  end
end
