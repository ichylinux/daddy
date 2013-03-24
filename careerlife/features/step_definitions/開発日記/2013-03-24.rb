# coding: UTF-8

前提 /^Gemfileを編集$/ do
  git_diff 'Gemfile', 'careerlife/Gemfile'
end

前提 /^capify \.$/ do
  files = []
  `git diff origin/p8 --name-only`.split("\n").each do |file|
    files << file unless file.start_with?('"careerlife/features')
  end
  
  puts "<pre>#{files.join("\n")}</pre>"
end
