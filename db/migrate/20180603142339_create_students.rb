class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.text :name
      t.text :result
      t.text :mother_existance
      t.text :parent_income

      t.timestamps
    end
  end
end
