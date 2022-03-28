class RenameCharacterColumnToCharacters < ActiveRecord::Migration[6.1]
  def change
    rename_column :characters, :character, :character_text
  end
end
