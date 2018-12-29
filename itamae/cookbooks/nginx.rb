require 'daddy/itamae'

include_recipe 'daddy::nginx::start'
include_recipe 'daddy::nginx::install'
include_recipe 'daddy::nginx::stop'
