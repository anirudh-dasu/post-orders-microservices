class CreateTableInvoices < Sequel::Migration
  def up
    create_table :invoices do
      primary_key :id
      column :created_at, :timestamp
      column :updated_at, :timestamp
      column :content, :text
    end
  end
  def down
    drop_table :invoices
  end
end