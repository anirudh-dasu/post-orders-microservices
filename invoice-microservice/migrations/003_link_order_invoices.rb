class LinkOrderInvoices < Sequel::Migration
  def up
    alter_table :invoices do 
      add_foreign_key :order_id, :orders
    end
  end
  def down
    remove_column :invoices, :order_id
  end
end