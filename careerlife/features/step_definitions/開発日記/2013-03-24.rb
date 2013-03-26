# coding: UTF-8

前提 /^Gemfileを編集$/ do
  git_diff 'Gemfile'
end

前提 /^capify \.$/ do
  `rm -Rf /tmp/careerlife`
  `cd /tmp && rails new careerlife -d mysql --skip-bundle`
  `cd /tmp/careerlife && capify .`

  %w(
    Capfile
    config/deploy.rb
  ).each do |file|
    diff file, "/tmp/careerlife/#{file}"
  end
end
