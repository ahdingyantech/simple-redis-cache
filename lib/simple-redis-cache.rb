require 'simple_redis_cache/config'

module SimpleRedisCache
  class Base
    extend SimpleRedisCache::Config
  end
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