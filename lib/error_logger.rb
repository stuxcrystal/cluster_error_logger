class ErrorLogger < Logger
	def format_message(severity, timestamp, progname, msg)
		"#{timestamp.to_formatted_s(:db)} #{severity} #{msg}\n"
	end
end
 
logfile = File.open("#{Rails.root}/../cluster_log/error.log", 'a') # create log file
logfile.sync = true # automatically flushes data to file
Log = ErrorLogger.new(logfile) # constant accessible anywhere