require "rails"

module ClusterErrorLogger
	class Railtie < Rails::Railtie
    initializer "cluster_error_logger.configure_rails_initialization" do
		  config.app_middleware.insert_before ActionDispatch::ParamsParser, "CatchJsonParseErrors"

		  logfile = File.open(File.expand_path("#{Rails.root}/../../../{cluster_log/error.log", 'a')) # create log file
			logfile.sync = true # automatically flushes data to file
			Log = ErrorLogger.new(logfile) # constant accessible anywhere
		end
	end
end