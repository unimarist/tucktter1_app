require 'rails_helper'

RSpec.describe '講師申請', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user.student_or_coach = "student" 
    @user.save
  end

  context '【正常系】講師申請_成功' do 
    it '正しく講師申請項目を入力した場合' do
      coach_request(@user)
    end
  end
  context '【異常系】講師申請_失敗' do
    it '誤った講師申請項目を入力した場合' do
        # ログインする
        sign_in(@user)
        # 講師申請ページへのリンクがあることを確認する
        expect(page).to have_content("コーチになる")
        # 講師申請ページへ移動する
        visit edit_user_path(@user.id)
        # 講師申請に必要な項目を入力しない
        fill_in 'user_FirstName', with: ""
        fill_in 'user_LastName', with: ""
        fill_in 'user_university', with: ""
        fill_in 'user_department', with: ""
        fill_in 'user_major', with: ""
        # 保存するユーザアイコンを定義する
        image_path = Rails.root.join('public/images/default_user.png')
        # 画像選択フォームにてユーザアイコンを添付する
        attach_file('user[user_icon]', image_path, make_visible: true)
        # 保存する本人認証画像を定義する
        image_path_2 = Rails.root.join('public/images/heart.png')
        # 画像選択フォームにてユーザアイコンを添付する
        attach_file('user[user_identification]', image_path_2, make_visible: true)
        # 「申請する」ボタンを押してもユーザーモデルのカウントは上がらないことを確認する
        expect{
          find('input[name="commit"]').click
        }.to change { User.count }.by(0)
        # 講師申請ページへ戻されることを確認する
        expect(current_path).to eq edit_user_path(@user.id)
    end
  end
end


RSpec.describe '講師承認', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user.student_or_coach = "student" 
    @user.save
    @admin = FactoryBot.create(:user)
    @admin.admin = "true" 
    @admin.save
  end

  context '【正常系】講師承認_成功' do 
    it '講師承認画面から講師申請を承認する場合' do
    #ユーザが講師申請をする
    coach_request(@user)
    #講師申請したユーザがログアウトする
    find_link('ログアウト', href: destroy_user_session_path).click
    #管理者がログインする
    sign_in(@admin)
    # 講師承認ページへのリンクがあることを確認する
    expect(page).to have_content("講師承認")
    # 講師承認ページへ移動する
    visit operations_path
    # 講師申請をしたユーザの情報が画面表示されていることを確認する
    expect(page).to have_content(@user.FirstName)
    expect(page).to have_content(@user.LastName )
    expect(page).to have_content(@user.university)
    expect(page).to have_content(@user.department)
    expect(page).to have_content(@user.major)
    # 「講師として承認する」ボタンを押下する
    visit edit_operation_path(@user.id)
    #管理者がログアウトする
    find_link('ログアウト', href: destroy_user_session_path).click
    #講師承認されたユーザがログインする
    sign_in(@user)
    #講師のみに付与されるアイコンが表示されることを確認する
    expect(page).to have_selector("img[src$='coach.png']")
    end
  end

  context '【異常系】講師承認_失敗' do 
    it '講師承認画面が表示されない場合' do
    #ユーザが講師申請をする
    coach_request(@user)
    #講師申請したユーザがログアウトする
    find_link('ログアウト', href: destroy_user_session_path).click
    #一般ユーザがログインする
    @admin.admin = "false"
    @admin.save
    sign_in(@admin)
    # 講師承認ページへのリンクがないことを確認する
    expect(page).to have_no_content("講師承認")
    end
  end

end