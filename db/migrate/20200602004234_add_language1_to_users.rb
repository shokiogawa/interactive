class AddLanguage1ToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :language1, foreign_key: true
  end
end
