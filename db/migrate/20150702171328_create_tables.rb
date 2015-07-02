class CreateTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
    end

    create_table :profiles do |t|
      t.integer :user_id
      t.string :fname
      t.string :lname
      t.integer :age
      t.string :email
      t.datetime :datetime
    end

    create_table :posts do |t|
      t.integer :user_id
      t.string :content
      t.datetime :datetime
    end

    create_table :friends do |t|
      t.integer :user_id
      t.integer :friend_id
    end
  end
end
