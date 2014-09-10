require_relative "error_logger"
require_relative "catch_json_parse_errors"
require_relative "railtie"

module ClusterErrorLogger
	def log_error(exception)
	  infos = []
	  infos << "Error raised when executing #{request.method} #{request.fullpath}"
	  infos << "Exception trace: \n\t#{exception.backtrace.take(5).join("\n\t")}"
	  infos << "\n\n"
	  $log.error infos.join("\n")
	  raise exception
	end
end
