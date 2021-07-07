class RenameStatusIdentificationColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :status_identification, :admin
  end
end
