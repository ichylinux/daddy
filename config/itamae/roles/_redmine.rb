ENV['APPLICATION_NAME'] ||= 'redmine'
ENV['APPLICATION_ENV'] ||= 'production'
ENV['APPLICATION_ROOT'] ||= '/opt/redmine/current'

include_recipe 'daddy::nginx'
include_recipe 'redmine'
