class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :name
      t.string :result
      t.string :mother_existance
      t.string :parent_income

      t.timestamps
    end
  end
end
