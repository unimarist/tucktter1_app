require 'rails_helper'

RSpec.describe Research, type: :model do
  before do
    @research = FactoryBot.build(:research)
  end

  describe '研究の投稿' do
    context "【正常系】研究の投稿_成功" do
      it "研究タイトル,研究概要、研究URLが存在する場合" do
        expect(@research).to be_valid
      end
      it "研究タイトルが50文字以内の場合" do
        @research.research_title = Faker::Lorem.characters(number: 50)
        expect(@research).to be_valid
      end
      it "研究概要が500文字以内の場合" do
        @research.research_summary = Faker::Lorem.characters(number: 500)
        expect(@research).to be_valid
      end
    end
    context "【異常系】研究の投稿_失敗" do
      it "研究タイトルが空の場合" do
        @research.research_title = ""
        @research.valid?
        expect(@research.errors.full_messages).to include "Research title can't be blank"
      end  
      it "研究概要が空の場合" do
        @research.research_summary = ""
        @research.valid?
        expect(@research.errors.full_messages).to include "Research summary can't be blank"
      end  
      it "研究URLが空の場合" do
        @research.research_url = ""
        @research.valid?
        expect(@research.errors.full_messages).to include "Research url can't be blank"
      end  
      it "研究タイトルが51文字以上の場合" do
        @research.research_title = Faker::Lorem.characters(number: 51)
        @research.valid?
        expect(@research.errors.full_messages).to include "Research title is too long (maximum is 50 characters)"
      end  
      it "研究概要が501文字以上の場合" do
        @research.research_summary = Faker::Lorem.characters(number: 501)
        @research.valid?
        expect(@research.errors.full_messages).to include "Research summary is too long (maximum is 500 characters)"
      end        
      it "ユーザーとのアソシエーションがない場合" do
        @research.user = nil
        @research.valid?
        expect(@research.errors.full_messages).to include "User must exist"
      end
    end
  end
end