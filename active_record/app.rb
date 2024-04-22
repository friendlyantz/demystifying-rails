require 'active_record'
require 'awesome_print'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/sample.sqlite3'
)

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    return if ActiveRecord::Base.connection.table_exists?(:users)

    create_table :users do |t|
      t.string :name
    end
  end
end

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
  validates_uniqueness_of :name, on: :create, message: "must be unique"

  has_many :posts
end

class Post < ActiveRecord::Base
  belongs_to :user
end

Post.destroy_all
User.destroy_all

User.create(name: 'Anton')
User.create(name: 'Mike')
User.create(name: 'Rian')
User.create(name: 'Jody')
User.create(name: 'Rubyists')

Post.create(user: User.first, content: 'Fresh comment🍋')
Post.create(user: User.find_by(name: 'Mike'), content: 'Jak się masz? Ship it!🛳️')
Post.create(user: User.find_by(name: 'Rian'), content: 'BuildKite rulez🪁')
Post.create(user: User.find_by(name: 'Jody'), content: 'Comment ça va de Jody🇫🇷')
