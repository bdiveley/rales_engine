class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      enable_extension :citext
      t.citext :first_name
      t.citext :last_name

      t.timestamps
    end
  end
end
