module CoachRequestSupport
  def coach_request(user)
      user.FirstName = Faker::Lorem.characters(number: 50)
      user.LastName = Faker::Lorem.characters(number: 50)
      user.university = Faker::Lorem.characters(number: 50)
      user.department = Faker::Lorem.characters(number: 50)
      user.major = Faker::Lorem.characters(number: 50)
      sign_in(user)
      # 講師申請ページへのリンクがあることを確認する
      expect(page).to have_content("コーチになる")
      # 講師申請ページへ移動する
      visit edit_user_path(user.id)
      # 講師申請に必要な項目を入力する
      fill_in 'user_FirstName', with: user.FirstName
      fill_in 'user_LastName', with: user.LastName
      fill_in 'user_university', with: user.university
      fill_in 'user_department', with: user.department
      fill_in 'user_major', with: user.major
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
      # 講師申請完了ページへ遷移することを確認する
       expect(page).to have_content('講師申請が完了しました。')
      # タイムラインへ戻る
      visit tweets_path
    end
  end
  