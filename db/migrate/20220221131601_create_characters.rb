class CreateCharacters < ActiveRecord::Migration[6.1]
  def change
    create_table :characters do |t|
      t.references :novel,          null: false, foreign_key: true
      t.text :character,            null: false
      t.string :character_role,     null: false
      t.datetime :created_at,       null: false
      t.datetime :updated_at,       null: false
    end
  end
end
