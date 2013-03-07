# coding: UTF-8

def run_phase(phase_no)
  if phase_no > 1 and not Dir.exist?("sample_#{phase_no -1}/tmp/careerlife")
    run_phase(phase_no -1)
  end

  puts "フェーズ #{phase_no} を実行します。"
  dir = "sample_#{phase_no}"
  
  system("rm -Rf #{dir}/features/reports")
  system("mkdir -p #{dir}/features/reports")
  system("rm -Rf #{dir}/tmp/careerlife")

  ret = system("cd #{dir} && bundle exec rake db:test:prepare")

  if ret
    ret = system("cd #{dir} && bundle exec cucumber -r features -f Daddy::Formatter::Html PHASE_NO=#{phase_no} EXPAND=true > features/reports/index.html")
  end

  if ret
    snapshot_to_tmp(dir)
  end
end

def snapshot_to_tmp(base_dir)
  return if base_dir.split('_')[1].to_i == 1

  system("rm -Rf #{base_dir}/tmp/careerlife")
  system("mkdir -p #{base_dir}/tmp/careerlife")

  %w{.gitignore config.ru Gemfile Gemfile.lock Rakefile README.rdoc}.each do |file|
    system("cp #{base_dir}/#{file} #{base_dir}/tmp/careerlife/")
  end

  %w{app config db doc lib log public script test vendor}.each do |dir|
    system("cp -R #{base_dir}/#{dir} #{base_dir}/tmp/careerlife/")
  end
end

def get_all_phase_no
  1..3
end

task :sample do |t|
  if ENV['PHASE_NO']
    samples = [ ENV['PHASE_NO'].to_i ]
  else
    samples = get_all_phase_no
  end

  samples.each do |sample_no|
    run_phase(sample_no)
  end
end

task :publish do |t|
  # samples = get_all_phase_no
  # samples.each do |sample_no|
    # run_phase(sample_no)
  # end
end

task :default => :sample
