class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.string :title
      t.text :description
      t.date :due_date
      t.boolean :due_date_soon, default: false
      t.boolean :overdue, default: false

      t.timestamps
    end
  end
end
