source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.5'
gem 'pg'
gem 'puma', '~> 3.7'
gem 'rack-cors'
gem 'active_model_serializers', '~> 0.10.0'
gem 'bcrypt', '~> 3.1.7'
gem 'knock'
gem 'multi_json', '~> 1.13.1'
gem 'oj', '~> 3.4.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem 'ffaker'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'pry-rails'
  gem 'email_spec', '~> 2.1.1'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
