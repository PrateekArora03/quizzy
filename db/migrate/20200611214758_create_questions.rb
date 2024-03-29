class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.text :description, null: false
      t.text :options, null: false, array: true,default: []
      t.integer :correct_answer, null: false
      t.references :quiz, null: false, foreign_key: { on_delete: :cascade }
      
      t.timestamps
    end
  end
end
