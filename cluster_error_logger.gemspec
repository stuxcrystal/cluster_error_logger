$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cluster_error_logger/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cluster_error_logger"
  s.version     = ClusterErrorLogger::VERSION
  s.authors     = ["Ninigi"]
  s.email       = ["fabian.zitter@gmail.com"]
  s.homepage    = "https://github.com/Ninigi/cluster_error_logger"
  s.summary     = "A Logger for a multi-JSON-API one-App Cluster, supposed to log errors in a central log file."
  s.description = "Bundle the gem in the App gem file, make a folder called 'cluster_error_log' in its parent folder and you are ready to go."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.11"

  s.add_development_dependency "sqlite3"
end
