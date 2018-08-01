class CreateUnlockedBodies < ActiveRecord::Migration[5.1]
  def change
    create_table :unlocked_bodies do |t|
      t.integer :user_id
      t.integer :body_id
      t.timestamps
    end
  end
end
