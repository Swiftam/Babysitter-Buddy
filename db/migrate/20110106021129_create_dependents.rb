class CreateDependents < ActiveRecord::Migration
  def self.up
    create_table :dependents do |t|
      t.integer :user_id
      t.string :name
      t.integer :age
      t.text :medications
      t.text :sleep_schedule
      t.text :food_schedule
      t.text :homework_schedule
      t.text :entertainment

      t.timestamps
    end
  end

  def self.down
    drop_table :dependents
  end
end
