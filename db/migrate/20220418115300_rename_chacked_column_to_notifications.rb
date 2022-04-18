class RenameChackedColumnToNotifications < ActiveRecord::Migration[6.1]
  def change
    rename_column :notifications, :chacked, :checked
  end
end
