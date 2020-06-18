class CreateAttempts < ActiveRecord::Migration[6.0]
  def change
    create_table :attempts do |t|
      t.boolean :submitted, null: false, default: false
      t.integer :correct_answers_count, null: false, default: 0
      t.integer :incorrect_answers_count, null: false, default: 0
      t.references :quiz, null: false, foreign_key: {on_delete: :cascade}
      t.references :user, null: false, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
  end
end
