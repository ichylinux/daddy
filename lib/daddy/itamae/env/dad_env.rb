def dad_env
  ret = ENV['DAD_ENV']
  ret ||= ENV['RAILS_ENV']
  ret ||= 'development'
end