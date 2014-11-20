require_relative "error_logger"
require_relative "arbitrary_stuff_logger"
require_relative "catch_json_parse_errors"
require_relative "railtie"

##
# Use these Methods to log your errors to a central File. Best practice would be to include into application_controller and rescue exceptions through +:log_exception+
module ClusterErrorLogger
  # Writes the exception with trace (current depth: 5) to cluster_log/error.log
	def log_exception(exception)
	  infos = []
	  infos << "Exception raised when executing #{request.method} #{request.fullpath}"
    infos << "#{exception}"
	  infos << "Exception trace: \n\t#{exception.backtrace.take(5).join("\n\t")}"
	  infos << "\n\n"
	  $log.error infos.join("\n")
	  raise exception
	end

  # Writes a multi line error message to cluster_log/error.log (default).
  # Takes an optional options hash (last argument)
  #
  # ====== Arguments
  # 
  # * +error_messages+ - Strings containinig what you want to be logged, every argument will be in a seperate line
  #
  # ====== Options
  #
  # If the last argument is a hash, it will be considered the options hash.
  # [:write_to]  
  #   * +:info+ write to cluster_log/info.log instead of **/error.log. 
  #   * +nil+ write to default.
  #
  # Go to #log_info for example code
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

  # Writes a multi line error message to cluster_log/error.log (default).
  # Takes an optional options hash (last argument)
  #
  # ====== Arguments
  # 
  # * +custom_infos+ - Strings containinig what you want to be logged, every argument will be in a seperate line
  #
  # ====== Options
  #
  # If the last argument is a hash, it will be considered the options hash.
  # [:write_to]  
  #   * +:error+ write to cluster_log/error.log instead of **/info.log. 
  #   * +nil+ write to default.
  # [:development_only]
  #   * +true+ only writes to log in dev or test environment. 
  #   * +false+ always writes to log. +Default: false+
  #
  # ====== Examples
  #
  #   log_info "They are everywhere!", "Then shoot everywhere!", :development_only => true, :write_to => :error
  #   # will write to error.log if Rails.env == 'development' || Rails.env == 'test'
  #   # => Info Triggered in request.method request.fullpath
  #   # => They are everywhere!
  #   # => Then shoot everywhere!
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

  # Writes a multi line error message to cluster_log/info.log (default).
  # Per default it only logs for dev/test environment (can be changed via option hash).
  # Takes an optional options hash (last argument)
  #
  # ====== Arguments
  # 
  # * +debug_infos+ - Strings containinig what you want to be logged, every argument will be in a seperate line
  #
  # ====== Options
  #
  # If the last argument is a hash, it will be considered the options hash.
  # [:write_to] 
  #   * +:error+, write to cluster_log/error.log instead of **/info.log. 
  #   * +nil+ write to default.
  # [:development_only] 
  #   * +true+ only writes to log in dev or test environment. 
  #   * +false+ always writes to log. 
  #   * +Default: true+.
  #
  # Go to #log_info for example code
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
