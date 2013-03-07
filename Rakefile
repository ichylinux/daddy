# coding: UTF-8

def run_phase(phase_no)
  puts "フェーズ #{phase_no} を実行します。"
  dir = "sample_#{phase_no}"
  
  system("rm -Rf #{dir}/features/reports")
  system("mkdir -p #{dir}/features/reports")
  system("cd #{dir} && rake dad:cucumber")
end

def get_all_phase_no
  ret = []
  Dir::glob(File.dirname(__FILE__) + '/sample_*').each do |dir|
    ret << File.basename(dir).split('_')[1].to_i
  end
  ret.sort
end

task :run do |t|
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
  Rake::Task['run'].execute
  get_all_phase_no.each do |no|
    # TODO
  end
end

task :default => :run
