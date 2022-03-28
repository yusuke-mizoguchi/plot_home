class ChangeDataReleaseToNovel < ActiveRecord::Migration[6.1]
  def change
    change_column :novels, :release, 'integer USING CAST(release AS integer)'
  end
end
