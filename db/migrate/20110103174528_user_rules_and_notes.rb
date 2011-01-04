class UserRulesAndNotes < ActiveRecord::Migration
  def self.up
    add_column :users, :house_rules, :text
    add_column :users, :babysitter_rules, :text
    User.reset_column_information
  end

  def self.down
    remove_column :users, :house_rules
    remove_column :users, :babysitter_rules
    User.reset_column_information
  end
end
