if ENV['CI']
  ENV['CODECLIMATE_REPO_TOKEN'] = '8d6ebf9e62d59c7ac7d99e41d28e06f466e74ffa1ed23f9a7fea19306f9761dc bundle exec rake'
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
else
  require 'simplecov'
  SimpleCov.start
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'mimir'
