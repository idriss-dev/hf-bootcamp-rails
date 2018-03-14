class AddOrganizationsAssociationToAccount < ActiveRecord::Migration[5.1]
  def change
    add_reference :organizations, :account, index: true
  end
end
