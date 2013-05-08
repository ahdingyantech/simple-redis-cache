require 'spec_helper'

describe SimpleRedisCache do
  it{
    # 创建两个分类
    @category_1 = Category.create!(:name => 'category_1')
    @category_2 = Category.create!(:name => 'category_2')
    # 创建两个用户
    @user_1 = User.create!(:name => 'user_1')
    @user_2 = User.create!(:name => 'user_2')

    @user_1.posts_db.should == []
    @user_2.posts_db.should == []
    @category_1.posts_db.should == []
    @category_2.posts_db.should == []

    @user_1.posts_count_db.should == 0
    @user_2.posts_count_db.should == 0
    @category_1.posts_count_db.should == 0
    @category_2.posts_count_db.should == 0

    @user_1.posts_of_category_db(@category_1).should == []
    @user_1.posts_of_category_db(@category_2).should == []
    @user_2.posts_of_category_db(@category_1).should == []
    @user_2.posts_of_category_db(@category_2).should == []
    @category_1.posts_of_user_db(@user_1).should == []
    @category_1.posts_of_user_db(@user_2).should == []
    @category_2.posts_of_user_db(@user_1).should == []
    @category_2.posts_of_user_db(@user_2).should == []

    @user_1.posts_count_of_category_db(@category_1).should == 0
    @user_1.posts_count_of_category_db(@category_2).should == 0
    @user_2.posts_count_of_category_db(@category_1).should == 0
    @user_2.posts_count_of_category_db(@category_2).should == 0
    @category_1.posts_count_of_user_db(@user_1).should == 0
    @category_1.posts_count_of_user_db(@user_2).should == 0
    @category_2.posts_count_of_user_db(@user_1).should == 0
    @category_2.posts_count_of_user_db(@user_2).should == 0
    
    @user_1.posts.should == []
    @user_2.posts.should == []
    @category_1.posts.should == []
    @category_2.posts.should == []

    @user_1.posts_count.should == '0'
    @user_2.posts_count.should == '0'
    @category_1.posts_count.should == '0'
    @category_2.posts_count.should == '0'

    @user_1.posts_of_category(@category_1).should == []
    @user_1.posts_of_category(@category_2).should == []
    @user_2.posts_of_category(@category_1).should == []
    @user_2.posts_of_category(@category_2).should == []
    @category_1.posts_of_user(@user_1).should == []
    @category_1.posts_of_user(@user_2).should == []
    @category_2.posts_of_user(@user_1).should == []
    @category_2.posts_of_user(@user_2).should == []

    @user_1.posts_count_of_category(@category_1).should == '0'
    @user_1.posts_count_of_category(@category_2).should == '0'
    @user_2.posts_count_of_category(@category_1).should == '0'
    @user_2.posts_count_of_category(@category_2).should == '0'
    @category_1.posts_count_of_user(@user_1).should == '0'
    @category_1.posts_count_of_user(@user_2).should == '0'
    @category_2.posts_count_of_user(@user_1).should == '0'
    @category_2.posts_count_of_user(@user_2).should == '0'

    # user_1 category_1 2
    @post_1 = @user_1.posts_db.create!(:name => 'post_1', :category => @category_1)
    @post_2 = @user_1.posts_db.create!(:name => 'post_2', :category => @category_1)
    @user_1.posts_db.reload
    @user_2.posts_db.reload
    @category_1.posts_db.reload
    @category_2.posts_db.reload

    @user_1.posts_db.should == [@post_2, @post_1]
    @user_2.posts_db.should == []
    @category_1.posts_db.should == [@post_2, @post_1]
    @category_2.posts_db.should == []

    @user_1.posts_count_db.should == 2
    @user_2.posts_count_db.should == 0
    @category_1.posts_count_db.should == 2
    @category_2.posts_count_db.should == 0

    @user_1.posts_of_category_db(@category_1).should == [@post_2, @post_1]
    @user_1.posts_of_category_db(@category_2).should == []
    @user_2.posts_of_category_db(@category_1).should == []
    @user_2.posts_of_category_db(@category_2).should == []
    @category_1.posts_of_user_db(@user_1).should == [@post_2, @post_1]
    @category_1.posts_of_user_db(@user_2).should == []
    @category_2.posts_of_user_db(@user_1).should == []
    @category_2.posts_of_user_db(@user_2).should == []

    @user_1.posts_count_of_category_db(@category_1).should == 2
    @user_1.posts_count_of_category_db(@category_2).should == 0
    @user_2.posts_count_of_category_db(@category_1).should == 0
    @user_2.posts_count_of_category_db(@category_2).should == 0
    @category_1.posts_count_of_user_db(@user_1).should == 2
    @category_1.posts_count_of_user_db(@user_2).should == 0
    @category_2.posts_count_of_user_db(@user_1).should == 0
    @category_2.posts_count_of_user_db(@user_2).should == 0
    
    @user_1.posts.should == [@post_2, @post_1]
    @user_2.posts.should == []
    @category_1.posts.should == [@post_2, @post_1]
    @category_2.posts.should == []

    @user_1.posts_count.should == '2'
    @user_2.posts_count.should == '0'
    @category_1.posts_count.should == '2'
    @category_2.posts_count.should == '0'

    @user_1.posts_of_category(@category_1).should == [@post_2, @post_1]
    @user_1.posts_of_category(@category_2).should == []
    @user_2.posts_of_category(@category_1).should == []
    @user_2.posts_of_category(@category_2).should == []
    @category_1.posts_of_user(@user_1).should == [@post_2, @post_1]
    @category_1.posts_of_user(@user_2).should == []
    @category_2.posts_of_user(@user_1).should == []
    @category_2.posts_of_user(@user_2).should == []

    @user_1.posts_count_of_category(@category_1).should == '2'
    @user_1.posts_count_of_category(@category_2).should == '0'
    @user_2.posts_count_of_category(@category_1).should == '0'
    @user_2.posts_count_of_category(@category_2).should == '0'
    @category_1.posts_count_of_user(@user_1).should == '2'
    @category_1.posts_count_of_user(@user_2).should == '0'
    @category_2.posts_count_of_user(@user_1).should == '0'
    @category_2.posts_count_of_user(@user_2).should == '0'

    # user_1 category_2 2
    @post_3 = @user_1.posts_db.create!(:name => 'post_3', :category => @category_2)
    @post_4 = @user_1.posts_db.create!(:name => 'post_4', :category => @category_2)    
    @user_1.posts_db.reload
    @user_2.posts_db.reload
    @category_1.posts_db.reload
    @category_2.posts_db.reload

    @user_1.posts_db.should == [@post_4, @post_3, @post_2, @post_1]
    @user_2.posts_db.should == []
    @category_1.posts_db.should == [@post_2, @post_1]
    @category_2.posts_db.should == [@post_4, @post_3]

    @user_1.posts_count_db.should == 4
    @user_2.posts_count_db.should == 0
    @category_1.posts_count_db.should == 2
    @category_2.posts_count_db.should == 2

    @user_1.posts_of_category_db(@category_1).should == [@post_2, @post_1]
    @user_1.posts_of_category_db(@category_2).should == [@post_4, @post_3]
    @user_2.posts_of_category_db(@category_1).should == []
    @user_2.posts_of_category_db(@category_2).should == []
    @category_1.posts_of_user_db(@user_1).should == [@post_2, @post_1]
    @category_1.posts_of_user_db(@user_2).should == []
    @category_2.posts_of_user_db(@user_1).should == [@post_4, @post_3]
    @category_2.posts_of_user_db(@user_2).should == []

    @user_1.posts_count_of_category_db(@category_1).should == 2
    @user_1.posts_count_of_category_db(@category_2).should == 2
    @user_2.posts_count_of_category_db(@category_1).should == 0
    @user_2.posts_count_of_category_db(@category_2).should == 0
    @category_1.posts_count_of_user_db(@user_1).should == 2
    @category_1.posts_count_of_user_db(@user_2).should == 0
    @category_2.posts_count_of_user_db(@user_1).should == 2
    @category_2.posts_count_of_user_db(@user_2).should == 0
    
    @user_1.posts.should == [@post_4, @post_3, @post_2, @post_1]
    @user_2.posts.should == []
    @category_1.posts.should == [@post_2, @post_1]
    @category_2.posts.should == [@post_4, @post_3]

    @user_1.posts_count.should == '4'
    @user_2.posts_count.should == '0'
    @category_1.posts_count.should == '2'
    @category_2.posts_count.should == '2'

    @user_1.posts_of_category(@category_1).should == [@post_2, @post_1]
    @user_1.posts_of_category(@category_2).should == [@post_4, @post_3]
    @user_2.posts_of_category(@category_1).should == []
    @user_2.posts_of_category(@category_2).should == []
    @category_1.posts_of_user(@user_1).should == [@post_2, @post_1]
    @category_1.posts_of_user(@user_2).should == []
    @category_2.posts_of_user(@user_1).should == [@post_4, @post_3]
    @category_2.posts_of_user(@user_2).should == []

    @user_1.posts_count_of_category(@category_1).should == '2'
    @user_1.posts_count_of_category(@category_2).should == '2'
    @user_2.posts_count_of_category(@category_1).should == '0'
    @user_2.posts_count_of_category(@category_2).should == '0'
    @category_1.posts_count_of_user(@user_1).should == '2'
    @category_1.posts_count_of_user(@user_2).should == '0'
    @category_2.posts_count_of_user(@user_1).should == '2'
    @category_2.posts_count_of_user(@user_2).should == '0'

    # user_2 category_1 2
    @post_5 = @user_2.posts_db.create!(:name => 'post_5', :category => @category_1)
    @post_6 = @user_2.posts_db.create!(:name => 'post_6', :category => @category_1)    
    @user_1.posts_db.reload
    @user_2.posts_db.reload
    @category_1.posts_db.reload
    @category_2.posts_db.reload

    @user_1.posts_db.should == [@post_4, @post_3, @post_2, @post_1]
    @user_2.posts_db.should == [@post_6, @post_5]
    @category_1.posts_db.should == [@post_6, @post_5, @post_2, @post_1]
    @category_2.posts_db.should == [@post_4, @post_3]

    @user_1.posts_count_db.should == 4
    @user_2.posts_count_db.should == 2
    @category_1.posts_count_db.should == 4
    @category_2.posts_count_db.should == 2

    @user_1.posts_of_category_db(@category_1).should == [@post_2, @post_1]
    @user_1.posts_of_category_db(@category_2).should == [@post_4, @post_3]
    @user_2.posts_of_category_db(@category_1).should == [@post_6, @post_5]
    @user_2.posts_of_category_db(@category_2).should == []
    @category_1.posts_of_user_db(@user_1).should == [@post_2, @post_1]
    @category_1.posts_of_user_db(@user_2).should == [@post_6, @post_5]
    @category_2.posts_of_user_db(@user_1).should == [@post_4, @post_3]
    @category_2.posts_of_user_db(@user_2).should == []

    @user_1.posts_count_of_category_db(@category_1).should == 2
    @user_1.posts_count_of_category_db(@category_2).should == 2
    @user_2.posts_count_of_category_db(@category_1).should == 2
    @user_2.posts_count_of_category_db(@category_2).should == 0
    @category_1.posts_count_of_user_db(@user_1).should == 2
    @category_1.posts_count_of_user_db(@user_2).should == 2
    @category_2.posts_count_of_user_db(@user_1).should == 2
    @category_2.posts_count_of_user_db(@user_2).should == 0

    @user_1.posts.should == [@post_4, @post_3, @post_2, @post_1]
    @user_2.posts.should == [@post_6, @post_5]
    @category_1.posts.should == [@post_6, @post_5, @post_2, @post_1]
    @category_2.posts.should == [@post_4, @post_3]

    @user_1.posts_count.should == '4'
    @user_2.posts_count.should == '2'
    @category_1.posts_count.should == '4'
    @category_2.posts_count.should == '2'

    @user_1.posts_of_category(@category_1).should == [@post_2, @post_1]
    @user_1.posts_of_category(@category_2).should == [@post_4, @post_3]
    @user_2.posts_of_category(@category_1).should == [@post_6, @post_5]
    @user_2.posts_of_category(@category_2).should == []
    @category_1.posts_of_user(@user_1).should == [@post_2, @post_1]
    @category_1.posts_of_user(@user_2).should == [@post_6, @post_5]
    @category_2.posts_of_user(@user_1).should == [@post_4, @post_3]
    @category_2.posts_of_user(@user_2).should == []

    @user_1.posts_count_of_category(@category_1).should == '2'
    @user_1.posts_count_of_category(@category_2).should == '2'
    @user_2.posts_count_of_category(@category_1).should == '2'
    @user_2.posts_count_of_category(@category_2).should == '0'
    @category_1.posts_count_of_user(@user_1).should == '2'
    @category_1.posts_count_of_user(@user_2).should == '2'
    @category_2.posts_count_of_user(@user_1).should == '2'
    @category_2.posts_count_of_user(@user_2).should == '0'

    # user_2 category_2 2
    @post_7 = @user_2.posts_db.create!(:name => 'post_7', :category => @category_2)
    @post_8 = @user_2.posts_db.create!(:name => 'post_8', :category => @category_2)    
    @user_1.posts_db.reload
    @user_2.posts_db.reload
    @category_1.posts_db.reload
    @category_2.posts_db.reload

    @user_1.posts_db.should == [@post_4, @post_3, @post_2, @post_1]
    @user_2.posts_db.should == [@post_8, @post_7, @post_6, @post_5]
    @category_1.posts_db.should == [@post_6, @post_5, @post_2, @post_1]
    @category_2.posts_db.should == [@post_8, @post_7, @post_4, @post_3]

    @user_1.posts_count_db.should == 4
    @user_2.posts_count_db.should == 4
    @category_1.posts_count_db.should == 4
    @category_2.posts_count_db.should == 4

    @user_1.posts_of_category_db(@category_1).should == [@post_2, @post_1]
    @user_1.posts_of_category_db(@category_2).should == [@post_4, @post_3]
    @user_2.posts_of_category_db(@category_1).should == [@post_6, @post_5]
    @user_2.posts_of_category_db(@category_2).should == [@post_8, @post_7]
    @category_1.posts_of_user_db(@user_1).should == [@post_2, @post_1]
    @category_1.posts_of_user_db(@user_2).should == [@post_6, @post_5]
    @category_2.posts_of_user_db(@user_1).should == [@post_4, @post_3]
    @category_2.posts_of_user_db(@user_2).should == [@post_8, @post_7]

    @user_1.posts_count_of_category_db(@category_1).should == 2
    @user_1.posts_count_of_category_db(@category_2).should == 2
    @user_2.posts_count_of_category_db(@category_1).should == 2
    @user_2.posts_count_of_category_db(@category_2).should == 2
    @category_1.posts_count_of_user_db(@user_1).should == 2
    @category_1.posts_count_of_user_db(@user_2).should == 2
    @category_2.posts_count_of_user_db(@user_1).should == 2
    @category_2.posts_count_of_user_db(@user_2).should == 2

    @user_1.posts.should == [@post_4, @post_3, @post_2, @post_1]
    @user_2.posts.should == [@post_8, @post_7, @post_6, @post_5]
    @category_1.posts.should == [@post_6, @post_5, @post_2, @post_1]
    @category_2.posts.should == [@post_8, @post_7, @post_4, @post_3]

    @user_1.posts_count.should == '4'
    @user_2.posts_count.should == '4'
    @category_1.posts_count.should == '4'
    @category_2.posts_count.should == '4'

    @user_1.posts_of_category(@category_1).should == [@post_2, @post_1]
    @user_1.posts_of_category(@category_2).should == [@post_4, @post_3]
    @user_2.posts_of_category(@category_1).should == [@post_6, @post_5]
    @user_2.posts_of_category(@category_2).should == [@post_8, @post_7]
    @category_1.posts_of_user(@user_1).should == [@post_2, @post_1]
    @category_1.posts_of_user(@user_2).should == [@post_6, @post_5]
    @category_2.posts_of_user(@user_1).should == [@post_4, @post_3]
    @category_2.posts_of_user(@user_2).should == [@post_8, @post_7]

    @user_1.posts_count_of_category(@category_1).should == '2'
    @user_1.posts_count_of_category(@category_2).should == '2'
    @user_2.posts_count_of_category(@category_1).should == '2'
    @user_2.posts_count_of_category(@category_2).should == '2'
    @category_1.posts_count_of_user(@user_1).should == '2'
    @category_1.posts_count_of_user(@user_2).should == '2'
    @category_2.posts_count_of_user(@user_1).should == '2'
    @category_2.posts_count_of_user(@user_2).should == '2'
  }
end