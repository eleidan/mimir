require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'mimir'
require 'aruba/cucumber'
