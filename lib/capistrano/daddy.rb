STDOUT.sync = true
Dir.glob(File.join(File.dirname(__FILE__), 'tasks/*.rake')).each { |r| import r }

require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git
