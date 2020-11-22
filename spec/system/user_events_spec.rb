require 'rails_helper'

RSpec.describe 'ユーザー予定作成機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user_event = FactoryBot.build(:user_event)
  end

  context '予定を作成できるとき' do
    it '正しい情報を入力すれば予定を作成できてカレンダーページに遷移する' do
      # ログインする
      user_sign_in(@user)
      # カレンダーのリンクが存在することを確認
      expect(page).to have_link("カレンダー")
      # 予定作成画面へ遷移する
      visit new_calendar_path
      # 予定作成画面へ遷移したことを確認する
      expect(current_path).to eq new_calendar_path
      # タイトルを入力
      fill_in 'user_event[title]', with: @user_event.title
      # 開始時刻の選択
      find("#user_event_start_time_1i").find("option[value='2015']").select_option
      find("#user_event_start_time_2i").find("option[value='8']").select_option
      find("#user_event_start_time_3i").find("option[value='10']").select_option
      find("#user_event_start_time_4i").find("option[value='12']").select_option
      find("#user_event_start_time_5i").find("option[value='00']").select_option
      # 終了時刻の選択
      find("#user_event_end_time_1i").find("option[value='2015']").select_option
      find("#user_event_end_time_2i").find("option[value='8']").select_option
      find("#user_event_end_time_3i").find("option[value='10']").select_option
      find("#user_event_end_time_4i").find("option[value='13']").select_option
      find("#user_event_end_time_5i").find("option[value='00']").select_option
      # 詳細の入力
      fill_in 'user_event[body]', with:@user_event.body
      # 作成するボタンをクリックするとUserEventモデルのカウント数が1増えることを確認する
      expect { find('input.btn-black').click }.to change { UserEvent.count }.by(1)
      # カレンダー画面に遷移していることを確認する
      expect(current_path).to eq calendars_path
    end
  end
  context 'イベント登録ができないとき' do
    it '誤った情報ではイベント登録ができずにカレンダーページへ戻ってくる' do
      # ログインする
      user_sign_in(@user)
      # カレンダーのリンクが存在することを確認
      expect(page).to have_link("カレンダー")
      # 予定作成画面へ遷移する
      visit new_calendar_path
      # 予定作成画面へ遷移したことを確認する
      expect(current_path).to eq new_calendar_path
      # 不正な情報を入力
      fill_in 'user_event[title]', with: ""
      # 作成するボタンをクリックしてもUserEventモデルのカウント数が増えないことを確認する
      expect { find('input.btn-black').click }.to change { UserEvent.count }.by(0)
      # カレンダー画面に遷移せず、作成ページに戻されることを確認する
      expect(current_path).to eq(calendars_path)
      # 戻された際にエラーメッセージが表示されることを確認する
      expect(page).to have_content("エラーが発生したため 予定 は保存されませんでした。")
      expect(page).to have_content("タイトルを入力してください")
    end

    it 'ログインしていない状態では予定を作成することができない' do
      # 予定作成画面へ遷移する
      visit new_calendar_path
      # 遷移されずにログイン画面に戻されることを確認する
      expect(current_path).to eq new_user_session_path
      # 戻されたときにエラーメッセージが表示されることを確認する
      expect(page).to have_content("ログインしてください")
    end
  end
end