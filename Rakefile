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
  system("cd #{dir} && bundle exec cucumber -r features -f Daddy::Formatter::Html PHASE_NO=#{phase_no} EXPAND=true > features/reports/index.html")
end

task :sample do |t|
  if ENV['PHASE_NO']
    samples = [ ENV['PHASE_NO'].to_i ]
  else
    samples = 1..2 
  end

  samples.each do |sample_no|
    run_phase(sample_no)
  end
end

task :default => :sample
