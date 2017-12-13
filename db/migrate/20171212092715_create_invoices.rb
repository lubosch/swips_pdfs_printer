class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.json :items
      t.json :general_info
      t.string :auth_token
      t.json :invoice_settings
      t.attachment :file

      t.timestamps
    end
    add_index :invoices, :auth_token, unique: true
  end
end
