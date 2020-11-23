require 'rails_helper'

RSpec.describe Sample, type: :model do
  before do
    @sample = FactoryBot.build(:sample)
  end

  describe 'カレンダー登録' do
    context 'カレンダーの登録がうまくいく時' do
      it 'title,start_time, end_time, bodyが全て存在するとき' do
        expect(@sample).to be_valid
      end

      it 'titleが20文字以内であるとき' do
        @sample.title = 'a' * 20
        expect(@sample).to be_valid
      end

      it 'bodyが無い場合' do
        @sample.body = nil
        expect(@sample).to be_valid
      end
    end

    context 'カレンダーの登録がうまくいかない時' do
      it 'titleが空だと登録できない' do
        @sample.title = nil
        @sample.valid?
        expect(@sample.errors.full_messages).to include('タイトルを入力してください')
      end

      it 'titleが21文字以上だと登録できない' do
        @sample.title = 'a' * 21
        @sample.valid?
        expect(@sample.errors.full_messages).to include('タイトルは20文字以内で入力してください')
      end

      it 'start_timeよりend_timeの時間が早いと登録できない' do
        @sample.end_time = '2020-11-22 04:57:00'
        @sample.valid?
        expect(@sample.errors.full_messages).to include("終了時刻は開始時刻と同じか、それより後の時刻でなければいけません")
      end
    end
  end
end
