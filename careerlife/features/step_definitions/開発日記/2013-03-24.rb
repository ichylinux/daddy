# coding: UTF-8

前提 /^Gemfileを編集$/ do
  git_diff 'Gemfile'
end

前提 /^Unicornをインストール$/ do
  puts 'rake dad:unicorn:install'
  show 'config/deploy.rb'
end

前提 /^Capistranoをインストール$/ do
  puts 'capify .'
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
