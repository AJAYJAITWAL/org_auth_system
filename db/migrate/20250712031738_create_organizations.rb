class CreateOrganizations < ActiveRecord::Migration[7.2]
  def change
    create_table :organizations do |t|
      t.string :name
      t.boolean :allow_posting

      t.timestamps
    end
  end
end
