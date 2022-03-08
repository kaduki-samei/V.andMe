class CreateNices < ActiveRecord::Migration[6.1]
  def change
    create_table :nices do |t|
      t.integer :post_id
      t.integer :ip_address

      t.timestamps
    end
  end
end
