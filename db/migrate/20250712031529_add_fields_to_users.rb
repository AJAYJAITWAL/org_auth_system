class AddFieldsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :date_of_birth, :date
    add_column :users, :parental_consent_given, :boolean
  end
end
