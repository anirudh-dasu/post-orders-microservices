class CreateTableOrders < Sequel::Migration
  def up
    create_table :orders do
      primary_key :id
      column :product_name, :text
      column :quantity, :text
      column :address, :text
      column :email, :text
      column :phone, :text
      column :created_at, :timestamp
      column :updated_at, :timestamp
    end
  end
  def down
    drop_table :orders
  end
end