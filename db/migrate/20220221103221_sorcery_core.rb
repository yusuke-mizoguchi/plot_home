class SorceryCore < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name,             null: false
      t.string :email,            null: false, index: { unique: true }
      t.string :crypted_password, null: false
      t.string :salt
      t.boolean :admin,           null: false, default: false
      t.integer :role,            null: false, default: 0
      t.text :profile
      t.datetime :created_at,       null: false
      t.datetime :updated_at,       null: false
    end
  end
end
