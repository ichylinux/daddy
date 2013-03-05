# coding: UTF-8

前提 /^以下のコマンドを実行する$/ do |table|
  commands = table.raw.map{|x| x[0]}
  commands.each do |command|
    if command.start_with?('rails new')
      system("cd tmp && rm -Rf careerlife && #{command} > /dev/null")
    elsif command.start_with?('rails s')
      fork do
        system("cd tmp/careerlife && #{command}")
      end
    else
      system("cd tmp/careerlife && #{command}")
    end
  end
end

ならば /^新しいアプリのひな形が生成される$/ do
  indent = '|'
  8.times{|i| indent = '&nbsp' + indent}
    
  # tree = `tree tmp/careerlife`
  # tree.gsub!(/\n/, '<br/>')
  # tree.gsub!(/`/, ' ')
  # tree.gsub!(/\|/, indent)
  # puts tree
  
  html = '<pre>'
  html << `tree tmp/careerlife`
  html << '</pre>'
  puts html
end

前提 /^アプリのひな形が生成されている$/ do
  directories = %w[app config db doc lib log public script test tmp vendor]
  directories.each do |dir|
    fail "ディレクトリ #{dir} が存在すること" unless Dir.exist?("tmp/careerlife/#{dir}")
  end
end

もし /^Gemfile に以下の gem を定義する$/ do |table|
  html = '<pre>'
  html << `diff features/data/Gemfile tmp/careerlife/Gemfile`
  html << '</pre>'
  puts html

  system("cp -f features/data/Gemfile tmp/careerlife/Gemfile")

  @gems = table.raw.map{|x| x[0]}
  @gems.each do |gem|
    assert system("grep #{gem} tmp/careerlife/Gemfile"), "#{gem} が含まれていること"
  end
  
end

ならば /^Gemfile\.lock が更新される$/ do
  
end

前提 /^Gemfile の編集が完了している$/ do
end

ならば /^WEBrickサーバが起動する$/ do
  sleep 5
  at_exit do
    Process.kill :KILL, `cat tmp/careerlife/tmp/pids/server.pid > /dev/null`.to_i
  end
end
