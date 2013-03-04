# coding: UTF-8

def exec_rails_new
  system("cd .. && rails new sample_1 -d mysql --force")
end

def exec_rails_start
  @pid = fork do
    system("rails s")
  end
end

前提 /^以下のコマンドを実行する$/ do |table|
  commands = table.raw.map
  commands.each do |c|
    if c[0].start_with?('rails new')
      assert exec_rails_new
    elsif c[0].start_with?('rails s')
      assert exec_rails_start
    else
      assert system(c[0])
    end
  end
end

ならば /^新しいアプリのひな形が生成される$/ do
  system('tree -I features')
end

前提 /^アプリのひな形が生成されている$/ do
  generated = true

  directories = %w[app config db doc lib log public script test tmp vendor]
  directories.each do |dir|
    generated = false unless Dir.exist?(dir)
  end
  
  assert exec_rails_new unless generated
end

もし /^Gemfile に以下の gem を定義する$/ do |table|
  system("cp -f features/data/Gemfile Gemfile")

  @gems = table.raw.map{|x| x[0]}
  @gems.each do |gem|
    assert system("grep #{gem} Gemfile"), "#{gem} が含まれていること"
  end
end

ならば /^Gemfile\.lock が更新される$/ do
  @gems.each do |gem|
    assert system("grep #{gem} Gemfile.lock"), "#{gem} が含まれていること"
  end
end

前提 /^Gemfile の編集が完了している$/ do
end

ならば /^WEBrickサーバが起動する$/ do
  sleep 10
  puts "プロセス #{@pid}"
  at_exit do
    Process.kill :KILL, `cat tmp/pids/server.pid`.to_i
  end
end
