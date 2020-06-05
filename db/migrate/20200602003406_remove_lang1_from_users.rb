class RemoveLang1FromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :lang1, :string
  end
end
