# coding: UTF-8

前提 /^Gemfileを編集$/ do
  git_diff 'Gemfile', :from => 34, :to => 35
end

前提 /^capify \./ do
  `rm -Rf /tmp/careerlife`
  `cd /tmp && rails new careerlife -d mysql --skip-bundle`
  `cd /tmp/careerlife && capify .`
end

前提 /^sudo bundle install$/ do
  git_diff 'Gemfile.lock', :as => 'auto'
end

前提 /^Capfileを編集$/ do
  diff 'Capfile', "/tmp/careerlife/Capfile"
end

前提 /^deploy\.rbを編集$/ do
  diff 'config/deploy.rb', "/tmp/careerlife/config/deploy.rb"
end
