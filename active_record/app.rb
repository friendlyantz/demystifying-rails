require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'sample.sqlite3'
)

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    return if ActiveRecord::Base.connection.table_exists?(:users)

    create_table :users do |t|
      t.string :name
    end
  end
end

CreateUsers.new.migrate(:up)

class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    return if ActiveRecord::Base.connection.table_exists?(:posts)

    create_table :posts do |t|
      t.text :content
      t.references :user, foreign_key: true
    end
  end
end

CreatePosts.new.migrate(:up)

class User < ActiveRecord::Base
  validates_presence_of :name, on: :create, message: "can't be blank"

  has_many :posts
end

class Post < ActiveRecord::Base
  belongs_to :user
end

binding.irb
