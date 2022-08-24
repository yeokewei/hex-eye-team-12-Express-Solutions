class CreatePredictions < ActiveRecord::Migration[7.0]
  def change
    create_table :predictions do |t|
      t.text :branch_name 
      t.text :service
      t.bigint :unixdate
      t.datetime :date
      t.float :prediction
      t.timestamps
    end
  end
end
