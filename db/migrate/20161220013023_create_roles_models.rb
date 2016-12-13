class CreateRolesModels < ActiveRecord::Migration[5.0]
  def change
    create_table :roles_models do |t|
      t.integer :code
      t.string :model_class_name
      t.integer :roles_group_id

      t.timestamps
    end
  end
end
