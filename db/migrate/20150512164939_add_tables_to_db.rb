class AddTablesToDb < ActiveRecord::Migration
  def change
    create_table(:surveys) do |t|
      t.column(:name, :string)
      t.timestamps()
    end

    create_table(:questions) do |t|
      t.column(:name, :string)
      t.column(:survey_id, :integer)
      t.timestamps()
    end
  end
end
