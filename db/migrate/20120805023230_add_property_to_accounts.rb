class AddPropertyToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :property, :text

  end
end
