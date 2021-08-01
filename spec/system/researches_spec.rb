require 'rails_helper'

RSpec.describe '研究投稿', type: :system do
  before do
      @user = FactoryBot.create(:user)
      @research = FactoryBot.build(:research)
  end
  context '【正常系】研究投稿_成功'do
  it 'ログインしたユーザーで研究を投稿する場合' do
    # ログインする
    sign_in(@user)
    # 研究投稿ページへのリンクがあることを確認する
    expect(page).to have_content('研究を投稿する')
    # 研究投稿ページに移動する
    visit new_research_path
    # 研究タイトルを入力する
    fill_in 'research_research_title', with: @research.research_title
    # 研究概要を入力する
    fill_in 'research_research_summary', with: @research.research_summary
    # 研究URLを入力する
    fill_in 'research_research_url', with: @research.research_url
    # 送信するとResearchモデルのカウントが1上がることを確認する
    expect{
    find('input[name="commit"]').click
    }.to change { Research.count }.by(1)
    # 研究投稿完了ページへ遷移することを確認する
    expect(page).to have_content('投稿が完了しました。')
    # 研究一覧ページに移動する
    visit researches_path
    # 研究一覧ページに先ほど投稿した研究の研究タイトルが存在することを確認する
    expect(page).to have_content(@research.research_title)
    # 研究一覧ページに先ほど投稿した研究の研究概要が存在することを確認する
    expect(page).to have_content(@research.research_summary)
    # 研究一覧ページに先ほど投稿した研究の研究URLが存在することを確認する
    expect(page).to have_content(@research.research_url)
    
  end
  end

  context '【異常系】研究登録_失敗'do
  it 'ユーザがログインしていない場合' do
     # 研究投稿ページへ遷移する
     visit new_research_path
     # 研究投稿ページへ遷移せず、トップページに戻ったことを確認する
     expect(current_path).to eq root_path
  end
  end
  
end


RSpec.describe '研究編集', type: :system do
  before do
    @research = FactoryBot.create(:research)
  end
  context '【正常系】研究編集_成功' do
    it 'ログインしたユーザーで研究を編集する場合' do
      # 研究を投稿したユーザーでログインする
      sign_in(@research.user)
      # 研究一覧ページに移動する
      visit researches_path
      # 研究編集ページへのリンクがあることを確認する
      expect(page).to have_content('編集') 
      # 編集ページへ遷移する
      visit edit_research_path(@research.id)
      # すでに投稿済みの内容がフォームに入っていることを確認する
       expect(
         find('#research_research_title').value 
       ).to eq @research.research_title
       expect(
         find('#research_research_summary').value 
       ).to eq @research.research_summary
       expect(
        find('#research_research_url').value 
      ).to eq @research.research_url
       # 投稿内容を編集する
       fill_in 'research_research_title', with: "#{@research.research_title}：編集"
       fill_in 'research_research_summary', with: "#{@research.research_summary}：編集"
       fill_in 'research_research_url', with: "#{@research.research_url}：編集"
       # 編集してもResearchモデルのカウントは変わらないことを確認する
       expect{
         find('input[name="commit"]').click
       }.to change { Research.count }.by(0)
       # 研究更新完了ページへ遷移することを確認する
       expect(page).to have_content('更新が完了しました。')
       # 研究一覧ページに移動する
       visit researches_path
       # 研究一覧ページに先ほど編集した研究の研究タイトルが存在することを確認する
       expect(page).to have_content("#{@research.research_title}：編集")
       # 研究一覧ページに先ほど編集した研究の研究概要が存在することを確認する
       expect(page).to have_content("#{@research.research_summary}：編集")
       # 研究一覧ページに先ほど編集した研究の研究URLが存在することを確認する
       expect(page).to have_content("#{@research.research_url}：編集")
     
    end
  end
  context '【異常系】研究編集_失敗' do
    it 'ユーザがログインしていない場合' do
      # 編集ページへ遷移する
      visit edit_research_path(@research.id)
      # 編集ページへ遷移せず、トップページに戻ったことを確認する
      expect(current_path).to eq root_path
    end
  end
end


RSpec.describe '研究削除', type: :system do
  before do
    @research = FactoryBot.create(:research)
  end
  context '【正常系】研究削除_成功' do
    it 'ログインしたユーザーで研究を削除する場合' do
      # 研究を投稿したユーザーでログインする
      sign_in(@research.user)
      # 研究一覧ページに移動する
      visit researches_path
      # 研究削除ページへのリンクがあることを確認する
      expect(page).to have_content('削除') 
      # 研究を削除するとレコードの数が1減ることを確認する
       expect{
         find_link('削除', href: research_path(@research.id)).click
       }.to change { Research.count }.by(-1)
      # 研究削除完了ページへ遷移することを確認する
      expect(page).to have_content('削除が完了しました。')
      # 研究一覧ページに移動する
      visit researches_path
      # 研究一覧ページに先ほど削除した研究の研究タイトルが存在しないことを確認する
      expect(page).to have_no_content("#{@research.research_title}")
      # 研究一覧ページに先ほど削除した研究の研究概要が存在しないことを確認する
      expect(page).to have_no_content("#{@research.research_summary}")
      # 研究一覧ページに先ほど削除した研究の研究URLが存在しないことを確認する
      expect(page).to have_no_content("#{@research.research_url}")
    end
  end
  context '【異常系】研究削除_失敗' do
    it 'ユーザがログインしていない場合' do
     # 研究一覧ページへ遷移する
     visit researches_path
     # 研究削除ページへのリンクがないことを確認する
     expect(page).to have_no_content('削除')
    end
  end
end