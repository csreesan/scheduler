class CreateSenrolls < ActiveRecord::Migration
  def change
    create_table :senrolls do |t|
      t.integer :user_id
      t.integer :course_id
      t.integer :section_id

      t.timestamps
    end
  end
end
