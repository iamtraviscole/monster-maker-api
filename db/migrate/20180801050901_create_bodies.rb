class CreateBodies < ActiveRecord::Migration[5.1]
  def change
    create_table :bodies do |t|
      t.string :body_type
      t.timestamps
    end
  end
end
