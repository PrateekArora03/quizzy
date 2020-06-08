class CreateQuizzes < ActiveRecord::Migration[6.0]
  def change
    create_table :quizzes do |t|
      t.string :name, null: false
      t.references :user, null: false, foreign_key: { on_delete: :restrict }

      t.timestamps
    end
  end
end
