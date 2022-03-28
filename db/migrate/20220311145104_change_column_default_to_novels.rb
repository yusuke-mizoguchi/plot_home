class ChangeColumnDefaultToNovels < ActiveRecord::Migration[6.1]
  def change
    change_column_default :novels, :release, from: nil, to: 0
  end
end
