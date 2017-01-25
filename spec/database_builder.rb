require 'database_helper'

def initialize_schema
  initialize_database do
    [:books, :readers, :libraries, :floors, :rooms].each do |table_name|
      create_table table_name do |t|
        t.string :name
      end
    end

    create_table "any_links" do |t|
      t.integer :id1
      t.string  :type1
      t.integer :id2
      t.string  :type2
    end

    add_index(:any_links, [:id1, :id2, :type1, :type2], unique: true)
    add_index(:any_links, [:id1, :type1, :type2])
    add_index(:any_links, [:id2, :type1, :type2])
  end
end

initialize_schema
