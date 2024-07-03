class CreateSurveys < ActiveRecord::Migration[6.1]
  def change
    create_table :surveys do |t|
      t.string :name
      t.text :discription

      t.timestamps
    end
  end
end
