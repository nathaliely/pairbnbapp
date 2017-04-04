class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.references :booking, index: true
      t.string :braintree_payment_id
      t.string :status
      t.string :fourdigit
    end
  end
end
