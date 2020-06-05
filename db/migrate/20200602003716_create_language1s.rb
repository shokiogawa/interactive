class CreateLanguage1s < ActiveRecord::Migration[5.2]
  def change
    create_table :language1s do |t|
      t.string :lang1

      t.timestamps
    end
  end
end
