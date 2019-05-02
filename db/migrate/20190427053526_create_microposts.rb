class CreateMicroposts < ActiveRecord::Migration[5.0]
  def change
    create_table :microposts do |t|
      t.string :content
      t.references :tasks, foreign_key: true

      t.timestamps
    end
  end
end
