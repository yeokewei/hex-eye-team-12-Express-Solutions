class CreateAllServices < ActiveRecord::Migration[7.0]
  def change
    create_table :all_services do |t|
      t.text :category
      t.integer :category_id
      t.text :service_id
      t.text :service
      t.text :migratable
      t.integer :count
      t.text :details
      t.integer :digital_time
      t.integer :branch_time
      t.text :service_image_link
      t.text :service_alt_text
      t.text :cat_image_link
      t.text :cat_alt_text
      t.timestamps
    end
  end
end
