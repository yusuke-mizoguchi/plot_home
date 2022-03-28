class AddReleaseToNovels < ActiveRecord::Migration[6.1]
  def change
    add_column :novels, :release, :string, null: false
  end
end
