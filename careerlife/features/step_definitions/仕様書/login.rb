# coding: UTF-8

前提 /^メールアドレス (.*?) が存在する$/ do |email|
  assert_not_nil User.find_by_email(email)
end

前提 /^ログイン をクリック$/ do
  if current_path == '/users/sign_in'
    within 'form.new_user' do
      click_on 'ログイン'
    end
  else
    click_on 'ログイン'
  end
end

前提 /^ログインに遷移$/ do
  assert_visit '/users/sign_in'
end

前提 /^(.*?) がログイン$/ do |email|
  fill_in 'メールアドレス', :with => email
  fill_in 'パスワード', :with => 'testtest'
  step 'ログイン をクリック'
end
