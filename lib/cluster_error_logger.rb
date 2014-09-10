require "error_logger"
module ClusterErrorLogger
	def log_error(exception)
	  infos = []
	  infos << "Error raised when executing #{request.method} #{request.fullpath}"
	  infos << "Exception trace: \n\t#{exception.backtrace.take(5).join("\n\t")}"
	  infos << "\n\n"
	  Log.error infos.join("\n")
	  raise exception
	end

	class CatchJsonParseErrors
	  def initialize(app)
	    @app = app
	  end

	  def call(env)
	    begin
	      @app.call(env)
	    rescue JSON::ParserError => error
	      infos = ["\tTriggered in Ticket Machine app: #{env['REQUEST_METHOD']} #{env['REQUEST_PATH']}"]
	      infos << "\tPARAMS:"
	      env['rack.session'].each do |key, val|
	        infos << "\t\t#{key}: #{val}"
	      end
	      infos << "\tCookies"
	      env[ "action_dispatch.request.unsigned_session_cookie"].each do |key, val|
	        infos << "\t\t#{key}: #{val}"
	      end
	      Log.error infos.join("\n")
	      raise error
	    end
	  end
	end
end
