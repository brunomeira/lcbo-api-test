source 'http://rubygems.org'

git_source(:github) do |repo_name|
	repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
	"https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.0'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem "react-rails"
gem "pure-css-rails"
gem 'fetch-rails'
gem 'faraday'
gem 'devise', github: 'plataformatec/devise', branch: 'master'
gem 'pg'
gem 'redis', '~> 3.0'
gem 'redis-namespace'
gem 'jbuilder', '~> 2.5'
gem 'will_paginate'

group :development, :test do
	gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
	gem 'rspec-rails', '~> 3.5'
end

group :test do
	gem "fakeredis"
end

group :development do
	gem 'web-console', '>= 3.3.0'
	gem 'listen', '>= 3.0.5', '< 3.2'
	gem 'yard'
	gem "letter_opener"
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
