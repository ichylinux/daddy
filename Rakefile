# coding: UTF-8

task :run do |t|
  if ENV['PHASE_NO']
    branch = 'p' + ENV['PHASE_NO']
  else
    branch = 'master'
  end
  
  system("cd careerlife && rake dad:cucumber")
end

task :publish do |t|
  Rake::Task['run'].execute
  get_all_phase_no.each do |no|
    # TODO
  end
end

task :default => :run
