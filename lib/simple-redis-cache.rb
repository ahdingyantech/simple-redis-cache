module SimpleRedisCache
  if defined?(Rails)
    RAILS_ENV = Rails.env.to_s
  else
    RAILS_ENV = 'test'
  end
end

require 'redis'
require 'simple_redis_cache/redis_cache'
require 'simple_redis_cache/management'
require 'simple_redis_cache/active_record_base_methods.rb'
require 'simple_redis_cache/base_proxy/redis_value_cache'
require 'simple_redis_cache/base_proxy/redis_value_cache_base_proxy'
require 'simple_redis_cache/base_proxy/redis_vector_array_cache'
require 'simple_redis_cache/base_proxy/redis_vector_array_cache_base_proxy'
require 'simple_redis_cache/config'
require 'simple_redis_cache/base_dsl_parser'
require 'simple_redis_cache/value_cache_dsl_parser'
require 'simple_redis_cache/vector_cache_dsl_parser'

module SimpleRedisCache
  extend SimpleRedisCache::Config
end


if defined?(Rails)

  module SimpleRedisCache
    class Railtie < Rails::Railtie

      config.to_prepare do
        filename = File.join(Rails.root.to_s, 'config/simple_redis_cache_config.rb')
        load filename if File.exists?(filename)
      end

      # generators do
      #   require File.expand_path("../../generators/simple_navbar_config_generator", __FILE__)
      # end

    end
  end
end

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.send(:include, SimpleRedisCache::ActiveRecordBaseMethods)
end