class ChangeNumericFieldInMessage < ActiveRecord::Migration[5.2]
  def change
    change_column(:messages, :message_amount, :decimal, :precision => 9, :scale => 2)
  end
end
