class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :email
      t.string :phone
      t.text :bio
      t.string :password_digest
      t.boolean :status
      t.timestamps
    end
  end
end
