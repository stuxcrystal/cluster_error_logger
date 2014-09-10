require_relative "error_logger"
require "cluster_error_logger/railtie" if defined?(Rails)

module ClusterErrorLogger
	def log_error(exception)
	  infos = []
	  infos << "Error raised when executing #{request.method} #{request.fullpath}"
	  infos << "Exception trace: \n\t#{exception.backtrace.take(5).join("\n\t")}"
	  infos << "\n\n"
	  Log.error infos.join("\n")
	  raise exception
	end
end
