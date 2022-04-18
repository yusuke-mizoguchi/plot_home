class CreateNotifacations < ActiveRecord::Migration[6.1]
  def change
    create_table :notifacations do |t|
      t.references :visitor, null: false, foreign_key: { to_table: :users }
      t.references :visited, null: false, foreign_key: { to_table: :users }
      t.references :novel, null: true, foreign_key: true
      t.references :review, null: true, foreign_key: true
      t.boolean :chacked, default: false, null: false

      t.timestamps
    end
  end
end
