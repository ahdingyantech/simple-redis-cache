# coding: utf-8
Gem::Specification.new do |s|
  s.name = 'simple-redis-cache'
  s.version = '0.0.0'
  s.platform = Gem::Platform::RUBY
  s.date = '2013-05-03'
  s.summary = 'simple-redis-cache'
  s.description = 'simple-redis-cache'
  s.authors = ['ben7th', 'fushang318']
  s.email = 'ben7th@sina.com'
  s.homepage = 'https://github.com/mindpin/simple-redis-cache'
  s.licenses = 'MIT'
  s.files = Dir.glob("lib/**/*") + %w(README.md)
  s.require_paths = ['lib']

  s.add_dependency 'redis', '3.0.3'
end