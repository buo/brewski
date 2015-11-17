require 'yaml'

module Brewski
  def self.config
    path = File.expand_path('../../../config/config.yaml', __FILE__)
    YAML.load_file(path)
  end
end
