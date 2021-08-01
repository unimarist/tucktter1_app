require 'rails_helper'

RSpec.describe 'アカウント登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context '【正常系】アカウント登録_成功' do 
    it '正しいアカウント情報を入力した場合' do
      # トップページに移動する
      visit root_path
      # トップページにアカウント登録ページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # アカウント登録ページへ移動する
      visit new_user_registration_path
      # アカウント情報を入力する
      fill_in 'user_email', with: @user.email
      fill_in 'user_Nickname', with: @user.Nickname
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password_confirmation
      # 「登録する」ボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # ログイン後ページへ遷移したことを確認する
      expect(current_path).to eq tweets_path
      # ログアウトボタンが表示されることを確認する
      expect(page).to have_content('ログアウト')
      # アカウント登録ページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context '【異常系】アカウント登録_失敗' do
    it '誤ったアカウント情報を入力した場合' do
      # トップページに移動する
      visit root_path
      # トップページにアカウント登録ページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # アカウント登録ページへ移動する
      visit new_user_registration_path
      # アカウント情報を入力する
      fill_in 'user_email', with: ""
      fill_in 'user_password', with: ""
      fill_in 'user_password_confirmation', with: ""
      # 「登録する」ボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # アカウント登録ページへ戻されることを確認する
      expect(current_path).to eq "/users"
    end
  end
end

RSpec.describe 'アカウント編集', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context '【正常系】アカウント編集_成功' do 
    it '正しいアカウント情報を入力した場合' do
      # アカウント編集をするユーザでログインする
      sign_in(@user)
      # アカウント編集ページに移動する
      visit edit_user_registration_path
      # すでに登録済みの内容がフォームに入っていることを確認する
      expect(
        find('#user_email').value 
      ).to eq @user.email
      expect(
        find('#user_Nickname').value 
      ).to eq @user.Nickname
      # アカウント情報を編集する
      @user.hobby = Faker::Lorem.characters(number: 100)
      @user.aWord = Faker::Lorem.characters(number: 100)
      fill_in 'user_email', with: 'edit@test'
      fill_in 'user_Nickname', with: 'edit_Nick'
      fill_in 'user_password', with: 'edit_password'
      fill_in 'user_password_confirmation', with: 'edit_password'
      fill_in 'user_hobby', with: @user.hobby
      fill_in 'user_aWord', with: @user.aWord
      fill_in 'user_current_password', with: @user.password
      # 編集してもUserモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # ログイン後ページへ遷移したことを確認する
      expect(current_path).to eq tweets_path
      # ユーザのニックネームが先ほど編集した値になっていることを確認する
      expect(page).to have_content('edit_Nick')
    end
  end
  
  context '【異常系】アカウント編集_失敗' do 
    it '100文字より多い趣味と一言を入力した場合' do
      # アカウント編集をするユーザでログインする
      sign_in(@user)
      # アカウント編集ページに移動する
      visit edit_user_registration_path
      # すでに登録済みの内容がフォームに入っていることを確認する
      expect(
        find('#user_email').value 
      ).to eq @user.email
      expect(
        find('#user_Nickname').value 
      ).to eq @user.Nickname
      # アカウント情報を編集する
      @user.hobby = Faker::Lorem.characters(number: 101)
      @user.aWord = Faker::Lorem.characters(number: 101)
      fill_in 'user_email', with: 'edit@test'
      fill_in 'user_Nickname', with: 'edit_Nick'
      fill_in 'user_password', with: 'edit_password'
      fill_in 'user_password_confirmation', with: 'edit_password'
      fill_in 'user_hobby', with: @user.hobby
      fill_in 'user_aWord', with: @user.aWord
      fill_in 'user_current_password', with: @user.password
      # 編集してもUserモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # エラーメッセージが表示され、編集失敗したことを確認する
      expect(page).to have_content('Aword is too long (maximum is 100 characters)')
    end
  end
end


RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context '【正常系】ログイン_成功' do
    it 'DBに保存されたログイン情報と入力したログイン情報が一致する場合' do
    # トップページに移動する
    visit root_path
    # トップページにログインページへ遷移するボタンがあることを確認する
    expect(page).to have_content('ログイン')
    # ログインページへ遷移する
    visit new_user_session_path
    # 正しいログイン情報を入力する
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    # ログインボタンを押す
    find('input[name="commit"]').click
    # ログイン後ページへ遷移することを確認する
    expect(current_path).to eq tweets_path
    # ログアウトボタンが表示されることを確認する
    expect(page).to have_content('ログアウト')
    # アカウント登録ページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
    expect(page).to have_no_content('新規登録')
    expect(page).to have_no_content('ログイン')
    end
  end
  context '【異常系】ログイン_失敗' do
    it 'DBに保存されたログイン情報と入力したログイン情報が一致しない場合' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # 誤ったログイン情報を入力する
      fill_in 'user_email', with: ""
      fill_in 'user_password', with: ""
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end