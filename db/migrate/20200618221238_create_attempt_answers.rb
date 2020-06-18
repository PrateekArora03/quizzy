class CreateAttemptAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :attempt_answers do |t|
      t.integer :submitted_option, null: false
      t.references :question, null: false, foreign_key: { on_delete: :cascade }
      t.references :attempt, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
