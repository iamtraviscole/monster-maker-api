class CreateMonsters < ActiveRecord::Migration[5.1]
  def change
    create_table :monsters do |t|
      t.integer :user_id
      t.string :name
      t.string :body_type
      t.string :body_fill
      t.string :face_type
      t.string :face_fill
      t.string :headwear_type
      t.string :headwear_fill
      t.string :eyes_type
      t.string :eyes_fill
      t.string :mouth_type
      t.string :mouth_fill
      t.string :right_arm_type
      t.string :right_arm_fill
      t.string :left_arm_type
      t.string :left_arm_fill
      t.string :legs_type
      t.string :legs_fill
      t.timestamps
    end
  end
end
