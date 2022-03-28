class CreateNovels < ActiveRecord::Migration[6.1]
  def change
    create_table :novels do |t|
      t.references :user,       null: false, foreign_key: true
      t.string :title,          null: false
      t.integer :genre,         null: false, default: 0
      t.integer :story_length,  null: false, default: 0
      t.text :plot,             null: false
      t.string :image
      t.datetime :created_at,       null: false
      t.datetime :updated_at,       null: false
    end
  end
end
