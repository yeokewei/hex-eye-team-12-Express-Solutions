class AddTopicsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :topics do |t|
      t.text :topic
    end
  end
end
