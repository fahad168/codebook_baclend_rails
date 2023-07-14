class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.string :text
      t.integer :user_id
      t.bigint :duration
      t.timestamps
    end
  end
end
