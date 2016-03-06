class SetDefaultStatus < ActiveRecord::Migration
  def change
  	Task.where(status: nil).update_all(status: "Open")
  	change_column_default :tasks, :status, "Open"
  	change_column_null :tasks, :status, false
  end
end
