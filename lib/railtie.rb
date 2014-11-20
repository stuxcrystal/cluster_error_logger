require "rails"

module ClusterErrorLogger
	class Railtie < Rails::Railtie
    initializer "cluster_error_logger.configure_rails_initialization" do
		  config.app_middleware.insert_before ActionDispatch::ParamsParser, "CatchJsonParseErrors"

		  logfile = File.open(File.expand_path("#{Rails.root}/../../cluster_log/error.log"), 'a') # create log file
      info_logfile = File.open(File.expand_path("#{Rails.root}/../../cluster_log/info.log"), 'a')

			logfile.sync = true # automatically flushes data to file
      info_logfile.sync = true
      
			$log = ErrorLogger.new(logfile) # constant accessible anywhere
      $arb_log = ArbitraryStuffLogger.new(info_logfile)
		end
	end
end