require 'rake'

namespace :dad do
  namespace :redis do

    desc I18n.t('redis.install')
    task :install do
      run_itamae 'redis/install'
    end

  end
end
