class UserName < ActiveRecord::Migration
  def self.up
    add_column :users, :name, :string
    User.reset_column_information
  end

  def self.down
    remove_column :users, :name
    User.reset_column_information
  end
end
