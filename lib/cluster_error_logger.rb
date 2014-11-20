require_relative "error_logger"
require_relative "arbitrary_stuff_logger"
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
    options = custom_infos.extract_options!

    infos = []
    infos << "Non-Exception Error raised when executing #{request.method} #{request.fullpath}"
    infos << "Error trace:"
    error_messages.each do |e_message|
      infos << "\t#{e_message}"
    end
    infos << "\n"

    if options[:write_to] && options[:write_to].to_sym == :info
      $arb_log.error infos.join("\n")
    else
      $log.error infos.join("\n")
    end
  end

  def log_info(*custom_infos)
    options = custom_infos.extract_options!
    options[:development_only] ||= false
    
    if options[:development_only] && Rails.env != 'production'
      infos = []
      infos << "Triggered in #{request.method} #{request.fullpath}"
      custom_infos.each do |message|
        infos << "\t#{message}"
      end
      infos << "\n"

      if options[:write_to] && options[:write_to].to_sym == :error
        $log.error infos.join("\n")
      else
        $arb_log.info infos.join("\n")
      end
    end
  end

  def log_debug(*debug_infos)
    options = debug_infos.extract_options!
    options[:development_only] ||= true

    if options[:development_only] && Rails.env != 'production'
      infos = []
      infos << "Triggered in #{request.method} #{request.fullpath}"
      debug_infos.each do |message|
        infos << "\t#{message}"
      end
      infos << "\n"
      
      if options[:write_to] && options[:write_to].to_sym == :error
        $log.error infos.join("\n")
      else
        $arb_log.info infos.join("\n")
      end
    end
  end
end
