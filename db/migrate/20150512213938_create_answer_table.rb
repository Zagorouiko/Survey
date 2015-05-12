class CreateAnswerTable < ActiveRecord::Migration
  def change
    create_table(:answer) do |t|
      t.column(:words, :string)
      t.column(:questions_id, :integer)
      t.timestamps()
    end
  end
end
