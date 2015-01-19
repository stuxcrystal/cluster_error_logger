require_relative "error_logger"
require_relative "arbitrary_stuff_logger"
require_relative "catch_json_parse_errors"
require_relative "railtie"
require 'gem_config'
require "core_log_methods"
require 'fileutils'

##
# Use these Methods to log your errors to a central File. Best practice would be to include into application_controller and rescue exceptions through +:log_exception+
module ClusterErrorLogger
  include GemConfig::Base

  with_configuration do
    has :log_dir, :classes => String, :default => File.expand_path("#{Rails.root}/../../cluster_log")
  end
end
