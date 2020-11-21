require 'rails_helper'

RSpec.describe Team, type: :model do
  before do
    @team = FactoryBot.build(:team)
  end

  describe 'チーム作成' do
    context 'チーム作成がうまくいく時' do
      it 'name,password,password_confirmationが全て条件を満たしているとき登録できる' do
        expect(@team).to be_valid
      end

      it 'nameが20文字いないの時' do
        @team.name = 'a' * 20
        expect(@team).to be_valid
      end
    end

    context 'チーム作成がうまくいかない時' do
      it 'nameが空だと登録できない' do
        @team.name = nil
        @team.valid?
        expect(@team.errors.full_messages).to include('チーム名を入力してください')
      end

      it 'nameが21文字以上だと登録できない' do
        @team.name = 'a' * 21
        @team.valid?
        expect(@team.errors.full_messages).to include('チーム名は20文字以内で入力してください')
      end

      it 'nameは重複して登録できない' do
        @team.save
        @another_team = FactoryBot.build(:team)
        @another_team.name = @team.name
        @another_team.valid?
        expect(@another_team.errors.full_messages).to include('チーム名はすでに存在します')
      end

      it 'passwordが空だと登録できない' do
        @team.password = nil
        @team.password_confirmation = nil
        @team.valid?
        expect(@team.errors.full_messages).to include('パスワードは不正な値です')
      end

      it 'passwordが5文字以下の英数字だと登録できない' do
        @team.password = '1111a'
        @team.password_confirmation = @team.password
        @team.valid?
        expect(@team.errors.full_messages).to include('パスワードは不正な値です')
      end

      it 'passwordが6文字以上の英字のみだと登録できない' do
        @team.password = 'aaaaaa'
        @team.password_confirmation = @team.password
        @team.valid?
        expect(@team.errors.full_messages).to include('パスワードは不正な値です')
      end

      it 'passwordが6文字以上の数字のみだと登録できない' do
        @team.password = '111111'
        @team.password_confirmation = @team.password
        @team.valid?
        expect(@team.errors.full_messages).to include('パスワードは不正な値です')
      end

      it 'password_confirmationが空だと登録できない' do
        @team.password_confirmation = ''
        @team.valid?
        expect(@team.errors.full_messages).to include('パスワード（確認用）を入力してください')
      end

      it 'passwordとpassword_confirmationが同じでないと登録できない' do
        @team.password = '11111a'
        @team.password_confirmation = '1111111a'
        @team.valid?
        expect(@team.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end
    end
  end
end
