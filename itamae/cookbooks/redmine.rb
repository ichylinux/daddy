require 'daddy/itamae'

include_recipe 'daddy::nginx::stop'
include_recipe 'daddy::nginx::install'
include_recipe 'daddy::redmine::install'
include_recipe 'daddy::nginx::start'
