class CategoryMigration < ActiveRecord::Migration
  def self.up
    create_table :categories, :force => true do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :categories
  end
end

class PostMigration < ActiveRecord::Migration
  def self.up
    create_table :posts, :force => true do |t|
      t.string :name
      t.integer :creator_id
    end
  end

  def self.down
    drop_table :posts
  end
end

class UserMigration < ActiveRecord::Migration
  def self.up
    create_table :users, :force => true do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :users
  end
end

class MigrationHelper
  def self.up
    CategoryMigration.up
    PostMigration.up
    UserMigration.up
  end

  def self.down
    CategoryMigration.down
    PostMigration.down
    UserMigration.down
  end
end