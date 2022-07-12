class AddPhoneToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :mobileno, :bigint
  end
end
