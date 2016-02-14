require 'daddy/itamae'

include_recipe File.expand_path(__FILE__, '../../install.rb')

execute 'docker pull registry'
