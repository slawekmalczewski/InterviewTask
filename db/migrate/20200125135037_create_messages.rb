class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :message_first_name
      t.string :message_last_name
      t.string :message_email
      t.decimal :message_amount

      t.timestamps
    end
  end
end
