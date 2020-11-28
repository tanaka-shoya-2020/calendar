require 'rails_helper'

RSpec.describe UserEvent, type: :model do
  before do
    @user_event = FactoryBot.build(:user_event)
  end

  describe 'カレンダー登録' do
    context 'カレンダーの登録がうまくいく時' do
      it 'title,start_time, end_time, bodyが全て存在するとき' do
        expect(@user_event).to be_valid
      end

      it 'titleが20文字以内であるとき' do
        @user_event.title = 'a' * 20
        expect(@user_event).to be_valid
      end

      it 'bodyが無い場合' do
        @user_event.body = nil
        expect(@user_event).to be_valid
      end
    end

    context 'カレンダーの登録がうまくいかない時' do
      it 'titleが空だと登録できない' do
        @user_event.title = nil
        @user_event.valid?
        expect(@user_event.errors.full_messages).to include('タイトルを入力してください')
      end

      it 'titleが21文字以上だと登録できない' do
        @user_event.title = 'a' * 21
        @user_event.valid?
        expect(@user_event.errors.full_messages).to include('タイトルは20文字以内で入力してください')
      end

      it 'start_timeがないと登録できない' do
        @user_event.start_time = nil
        @user_event.valid?
        expect(@user_event.errors.full_messages).to include("開始時刻が入力されていません")
      end
      
      it 'userとの関連付けがない場合登録できない' do
        @user_event.user = nil
        @user_event.valid?
        expect(@user_event.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
