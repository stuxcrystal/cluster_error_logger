require_relative "error_logger"
require_relative "catch_json_parse_errors"
require_relative "railtie"

module ClusterErrorLogger
	def log_exception(exception)
	  infos = []
	  infos << "Error raised when executing #{request.method} #{request.fullpath}"
	  infos << "Exception trace: \n\t#{exception.backtrace.take(5).join("\n\t")}"
	  infos << "\n\n"
	  $log.error infos.join("\n")
	  raise exception
	end

  def log_error(*error_messages)
    infos = []
    infos << "Non-Exception Error raised when executing #{request.method} #{request.fullpath}"
    infos << "Error trace:"
    error_messages.each do |e_message|
      infos << "\n\t#{e_message}"
    end
    infos << "\n\n"
    $log.error infos.join("\n")
  end

  def log_info(*custom_infos)
    infos = []
    infos << "Triggered in #{request.method} #{request.fullpath}"
    custom_infos.each do |message|
      infos << "\n\t#{message}"
    end
    infos << "\n\n"
    $log.info infos.join("\n")
  end
end
