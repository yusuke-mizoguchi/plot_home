class RemovePlotFromNovels < ActiveRecord::Migration[6.1]
  def change
    remove_column :novels, :plot, :text
    remove_column :characters, :character_text, :text
    remove_column :users, :profile, :text
  end
end
