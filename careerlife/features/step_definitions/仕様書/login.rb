# coding: UTF-8

前提 /^メールアドレス (.*?) が存在(する|しない)$/ do |email, suffix|
  assert_equal suffix == 'する', User.where(:email => email).present?
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

ならば /^アカウント作成画面に遷移$/ do
  assert_url '/users/sign_up'
end

前提 /^(.*?) がログイン$/ do |email|
  fill_in 'メールアドレス', :with => email
  fill_in 'パスワード', :with => 'testtest'
  step 'ログイン をクリック'
end

前提 /^(.*?) がログインしている$/ do |email|
  user = User.find_by_email(email)
  assert_not_nil user

  visit '/users/sign_in'
  step "#{user.email} がログイン"
  @current_user = user
end
