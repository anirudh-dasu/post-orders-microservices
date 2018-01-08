require_relative '../app'
require 'yaml'

# Rabbitmq
rabbit_config_file = File.join(File.dirname(__FILE__),'','rabbitmq.yml')
RABBIT_CONFIG = YAML.load(File.read(rabbit_config_file))