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

      it 'titleが50文字以内であるとき' do
        @sample.title = 'a' * 50
        expect(@sample).to be_valid
      end

      it 'start_timeが無い場合' do
        @sample.start_time = nil
        expect(@sample).to be_valid
      end

      it 'end_timeが無い場合' do
        @sample.end_time = nil
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

      it 'titleが50文字以上だと登録できない' do
        @sample.title = 'a' * 51
        @sample.valid?
        expect(@sample.errors.full_messages).to include('タイトルは50文字以内で入力してください')
      end
    end
  end
end
