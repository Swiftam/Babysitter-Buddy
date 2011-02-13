class Contactfields < ActiveRecord::Migration
  def self.up
    add_column :contacts, :name, :string
    add_column :contacts, :number, :string
    Contact.reset_column_information
  end

  def self.down
    remove_column :contacts, :name
    remove_column :contacts, :number
    Contact.reset_column_information
    end
end
