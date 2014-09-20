class CreateDreams < ActiveRecord::Migration
  def change
    create_table :dreams do |t|
      t.text :content
      t.datetime :dream_date
      t.string :visibility
      t.integer :user_id

      t.timestamps
    end

    add_index :dreams, [:user_id, :created_at]
  end
end
