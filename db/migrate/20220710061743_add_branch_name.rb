class AddBranchName < ActiveRecord::Migration[7.0]
  def change
    create_table :branches do |t|
      t.text :bank
      t.text :branch_name
      t.text :branch
      t.text :sms_number
      t.integer :wait_time
    end
   end
end
