require 'rack'
require './config/application'
require './config/routes'

run App.new
