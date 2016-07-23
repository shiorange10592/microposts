class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.references :user, index: true, foreign_key: true
      t.text :content

      t.index [:user_id, :created_at]

      t.timestamps null: false
    end
  end
end
