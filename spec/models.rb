class User < ActiveRecord::Base
  has_many :posts_db, :class_name => 'Post', :foreign_key => :creator_id

  def posts_of_category_db(category)
    posts_db.where(:category_id => category.id)
  end

  def posts_count_db
    posts_db.count
  end

  def posts_count_of_category_db(category)
    posts_db.where(:category_id => category.id).count
  end
end

class Category < ActiveRecord::Base
  has_many :posts_db, :class_name => 'Post'
  def posts_of_user_db(user)
    posts_db.where(:creator_id => user.id)
  end

  def posts_count_db
    posts_db.count
  end

  def posts_count_of_user_db(user)
    posts_db.where(:creator_id => user.id).count
  end
end

class Post < ActiveRecord::Base
  belongs_to :creator, :class_name => 'User'
  belongs_to :category

  default_scope :order => 'id DESC'
end