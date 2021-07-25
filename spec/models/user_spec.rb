require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = FactoryBot.build(:user)
    @coach = @user
  end

  describe "アカウント登録" do  

   context '【正常系】アカウント登録_成功' do
    it "email,Nickname、password、password_confirmationが存在する場合" do
      expect(@user).to be_valid
    end

    it "Nicknameが15文字以下の場合" do
      @user.Nickname = Faker::Name.initials(number: 15)
      expect(@user).to be_valid
    end

    it "passwordとpassword_confirmationが6文字以上30文字以下の場合" do
      @user.password = Faker::Internet.password(min_length: 6,max_length: 30)
      @user.password_confirmation = @user.password
      expect(@user).to be_valid
    end
   end


   context '【異常系】アカウント登録_失敗' do
    it "emailが空の場合" do
      @user.email =""
      @user.valid?
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end
    it "Nicknameが空の場合" do
      @user.Nickname =""
      @user.valid?
      expect(@user.errors.full_messages).to include "Nickname can't be blank"
    end
    it "passwordが空の場合" do
      @user.password = ""
      @user.valid?
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end
    it "passwordが存在し、password_confirmationが空の場合" do
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end
    it "重複したemailが存在する場合" do
      @user.save
      another = FactoryBot.build(:user)
      another.email = @user.email
      another.valid?
      expect(another.errors.full_messages).to include "Email has already been taken"  
    end
    it "重複したNicknameが存在する場合" do
      @user.save
      another = FactoryBot.build(:user)
      another.Nickname = @user.Nickname
      another.valid?
      expect(another.errors.full_messages).to include "Nickname has already been taken"  
    end
    it "Nicknameが16文字以上の場合" do
      @user.Nickname = Faker::Name.initials(number: 16)
      @user.valid?
      expect(@user.errors.full_messages).to include "Nickname is too long (maximum is 15 characters)"
    end
    it "passwordが5文字以下の場合" do
      @user.password =  "test1"
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
    end
    it "passwordが30文字以上の場合" do
      @user.password =  Faker::Internet.password(min_length: 31)
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include "Password is too long (maximum is 30 characters)"
    end
   end
  end


end