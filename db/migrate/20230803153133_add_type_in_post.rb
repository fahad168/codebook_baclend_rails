class AddTypeInPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :video_type, :string
    add_column :posts, :thumbnail, :string
  end
end
