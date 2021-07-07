class RenameStudentOrCauchColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :student_or_cauch, :student_or_coach
  end
end
