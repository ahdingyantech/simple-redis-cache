SimpleRedisCache.config do
  ## 字符串缓存
  #1 user.posts_count_db 的缓存
  #2 category.posts_count_db 的缓存
  #3 user.posts_count_of_category_db(category) 的缓存
  #4 category.posts_count_of_user_db(user) 的缓存

  ## 向量缓存
  #5 user.posts_db 的缓存
  #6 category.posts_db 的缓存
  #7 user.posts_of_category_db(category) 的缓存
  #8 category.posts_count_of_user_db(user) 的缓存

  # 1
  value_cache :name => :posts_count, :params => [], :caller => User do

    rules do
      after_save Post do |post|
        refresh_cache(post.creator)
      end
      after_destroy Post do |post|
        delete_cache(post.creator)
      end
    end

  end

  # 2
  value_cache :name => :posts_count, :params => [], :caller => Category do

    rules do
      after_save Post do |post|
        refresh_cache(post.category)
      end
      after_destroy Post do |post|
        delete_cache(post.category)
      end
    end

  end

  # 3
  value_cache :name => :posts_count_of_category, :params => [:category], :caller => User do
  
    rules do
      after_save Post do |post|
        refresh_cache(post.creator, post.category)
      end
      after_destroy Post do |post|
        delete_cache(post.creator, post.category)
      end
    end

  end

  # 4
  value_cache :name => :posts_count_of_user, :params => [:user], :caller => Category do
    
    rules do
      after_save Post do |post|
        refresh_cache(post.category, post.creator)
      end
      after_destroy Post do |post|
        delete_cache(post.category, post.creator)
      end
    end

  end

  # 向量缓存
  # 5
  vector_cache  :name => :posts,
                :params => [],
                :caller => User,
                :model => Post do

    rules do
      after_save Post do |post|
        add_to_cache(post.id, post.creator)
      end

      after_destroy Post do |post|
        remove_from_cache(post.id, post.creator)
      end
    end

  end

  # 6
  vector_cache  :name => :posts,
                :params => [],
                :caller => Category,
                :model => Post do

    rules do
      after_save Post do |post|
        add_to_cache(post.id, post.category) 
      end

      after_destroy Post do |post|
        remove_from_cache(post.id, post.category)
      end
    end

  end

  # 7
  vector_cache  :name => :posts_of_category,
                :params => [:category],
                :caller => User,
                :model => Post do

    rules do
      after_save Post do |post|
        add_to_cache(post.id, post.creator, post.category) 
      end

      after_destroy Post do |post|
        remove_from_cache(post.id, post.creator, post.category)
      end
    end

  end

  # 8
  vector_cache  :name => :posts_of_user,
                :params => [:user],
                :caller => Category,
                :model => Post do

    rules do
      after_save Post do |post|
        add_to_cache(post.id, post.category, post.creator) 
      end

      after_destroy Post do |post|
        remove_from_cache(post.id, post.category, post.creator) 
      end
    end

  end

end