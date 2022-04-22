class AddColumunsToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :comment, :text
    add_reference :reviews, :parent, foreign_key: { to_table: :reviews }
  end
end
