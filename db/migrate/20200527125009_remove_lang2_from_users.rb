class RemoveLang2FromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :lang2, :string
  end
end
