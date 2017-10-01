STDOUT.sync = true
Dir.glob(File.join(File.dirname(__FILE__), 'tasks/*.rake')).each { |r| import r }

set :passenger_restart_with_sudo, true
