class ChangeColumnToNull < ActiveRecord::Migration[6.1]
  def up
    change_column_null :characters, :character, :text, null: true
    change_column_null :characters, :character_role, :string, null: true
  end

  def down
    change_column_null :characters, :character, :text, null: false
    change_column_null :characters, :character_role, :string, null: false
  end
end
