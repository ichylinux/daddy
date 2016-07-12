def dad_env
  ENV['DAD_ENV'] ||= ENV['RAILS_ENV']
  ENV['DAD_ENV'] ||= 'development'
end