# coding: UTF-8

前提 /^index.html.erb を修正$/ do
  git_diff('app/views/top/index.html.erb', 'careerlife/app/views/top/index.html.erb')
end

前提 /^削除のシナリオを追加$/ do
  git_diff('features/仕様書/02.キャリア.feature', 'careerlife/features/仕様書/02.キャリア.feature')
  git_diff('features/step_definitions/仕様書/steps.rb', 'careerlife/features/step_definitions/仕様書/steps.rb')
end
