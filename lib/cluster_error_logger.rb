require_relative "error_logger"

module ClusterErrorLogger
	def log_error(exception)
		puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
	  infos = []
	  infos << "Error raised when executing #{request.method} #{request.fullpath}"
	  infos << "Exception trace: \n\t#{exception.backtrace.take(5).join("\n\t")}"
	  infos << "\n\n"
	  Log.error infos.join("\n")
	  raise exception
	end
end
