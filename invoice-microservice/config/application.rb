require_relative '../app'
require 'yaml'
require 'sequel'


db_config_file = File.join(File.dirname(__FILE__), '', 'database.yml')
if File.exist?(db_config_file)
  config = YAML.load(File.read(db_config_file))
  DB = Sequel.connect(config)
  Sequel.extension :migration   ## migration extension for sequel.
  Sequel::Model.plugin :timestamps, update_on_create: true ## Create timestamp entries by default
  Sequel::Model.plugin :json_serializer ## json serializer extension to convert model objects to json
end

# If there is a database connection, run all the migrations
if DB
  Sequel::Migrator.run(DB, File.join(File.dirname(__FILE__), '../migrations'))
end


# Load models
Dir[File.join(File.dirname(__FILE__), '../app/models', '**', '*.rb')].sort.each {|file| require file }

# Load controllers
Dir[File.join(File.dirname(__FILE__), '../app/controllers', '**', '*.rb')].sort.each {|file| require file }

# Rabbitmq
rabbit_config_file = File.join(File.dirname(__FILE__),'','rabbitmq.yml')
RABBIT_CONFIG = YAML.load(File.read(rabbit_config_file))