require 'rails_helper'

RSpec.describe TeamEvent, type: :model do
  before do
    @team_event = FactoryBot.build(:team_event)
  end

  describe 'カレンダー登録' do
    context 'カレンダーの登録がうまくいく時' do
      it 'title,start_time, end_time, bodyが全て存在するとき' do
        expect(@team_event).to be_valid
      end

      it 'titleが50文字以内であるとき' do
        @team_event.title = 'a' * 50
        expect(@team_event).to be_valid
      end

      it 'start_timeが無い場合' do
        @team_event.start_time = nil
        expect(@team_event).to be_valid
      end

      it 'end_timeが無い場合' do
        @team_event.end_time = nil
        expect(@team_event).to be_valid
      end

      it 'bodyが無い場合' do
        @team_event.body = nil
        expect(@team_event).to be_valid
      end
    end

    context 'カレンダーの登録がうまくいかない時' do
      it 'titleが空だと登録できない' do
        @team_event.title = nil
        @team_event.valid?
        expect(@team_event.errors.full_messages).to include('タイトルを入力してください')
      end

      it 'titleが50文字以上だと登録できない' do
        @team_event.title = 'a' * 51
        @team_event.valid?
        expect(@team_event.errors.full_messages).to include('タイトルは50文字以内で入力してください')
      end

      it 'teamとの関連付けがない場合登録できない' do
        @team_event.team = nil
        @team_event.valid?
        expect(@team_event.errors.full_messages).to include('Teamを入力してください')
      end
    end
  end
end
