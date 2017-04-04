class FixEverything < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :image, :string
    add_column :listings, :images, :json
  end
end
