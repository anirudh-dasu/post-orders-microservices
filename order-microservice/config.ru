require_relative 'app'
require 'yaml'
require 'sequel'

# Init Db. Don't forget to create database manually first
db_config_file = File.join(File.dirname(__FILE__), 'config', 'database.yml')
if File.exist?(db_config_file)
  config = YAML.load(File.read(db_config_file))
  DB = Sequel.connect(config)
  ## migration extension for sequel.
  Sequel.extension :migration
  Sequel::Model.plugin :timestamps, update_on_create: true
end

# If there is a database connection, run all the migrations
if DB
  Sequel::Migrator.run(DB, File.join(File.dirname(__FILE__), 'migrations'))
end


# Load models
Dir[File.join(File.dirname(__FILE__), 'app/models', '**', '*.rb')].sort.each {|file| require file }

# Load controllers
Dir[File.join(File.dirname(__FILE__), 'app/controllers', '**', '*.rb')].sort.each {|file| require file }


run App.router
