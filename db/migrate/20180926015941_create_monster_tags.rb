class CreateMonsterTags < ActiveRecord::Migration[5.1]
  def change
    create_table :monster_tags do |t|
      t.integer :monster_id
      t.integer :tag_id
      t.timestamps
    end
  end
end
