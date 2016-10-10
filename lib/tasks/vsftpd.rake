require_relative 'task_helper'

namespace :dad do
  namespace :vsftpd do

    desc I18n.t('vsftpd.install')
    task :install do
      run_itamae 'vsftpd/install'
    end

  end
end
