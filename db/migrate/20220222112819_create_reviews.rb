class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :user,           null: false, foreign_key: true
      t.references :novel,          null: false, foreign_key: true
      t.text :good_point,           null: false
      t.text :bad_point
      t.datetime :created_at,       null: false
      t.datetime :updated_at,       null: false
    end
  end
end
