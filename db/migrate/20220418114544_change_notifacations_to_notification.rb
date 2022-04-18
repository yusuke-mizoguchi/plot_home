class ChangeNotifacationsToNotification < ActiveRecord::Migration[6.1]
  def change
    rename_table :notifacations, :notifications
  end
end
