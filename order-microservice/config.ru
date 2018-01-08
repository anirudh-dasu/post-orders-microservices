require_relative 'config/application.rb'

use Rack::PostBodyContentTypeParser
run App.router