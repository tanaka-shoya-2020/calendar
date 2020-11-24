require 'rails_helper'

RSpec.describe 'チーム予定作成機能', type: :system do
  before do
    @team = FactoryBot.create(:team)
    @team_event = FactoryBot.build(:team_event)
  end

  context '予定を作成できるとき' do
    it '正しい情報を入力すれば予定を作成できてカレンダーページに遷移する' do
      # ログインする
      team_sign_in(@team)
      # カレンダーのリンクが存在することを確認
      expect(page).to have_link('カレンダー')
      # 予定作成画面へ遷移する
      visit new_calendar_path
      # 予定作成画面へ遷移したことを確認する
      expect(current_path).to eq new_calendar_path
      # タイトルを入力
      fill_in 'team_event[title]', with: @team_event.title
      # 開始時刻の選択
      find('#team_event_start_time_1i').find("option[value='2020']").select_option
      find('#team_event_start_time_2i').find("option[value='11']").select_option
      find('#team_event_start_time_3i').find("option[value='25']").select_option
      find('#team_event_start_time_4i').find("option[value='12']").select_option
      find('#team_event_start_time_5i').find("option[value='00']").select_option
      # 終了時刻の選択
      find('#team_event_end_time_4i').find("option[value='13']").select_option
      find('#team_event_end_time_5i').find("option[value='00']").select_option
      sleep 1
      # 詳細の入力
      fill_in 'team_event[body]', with: @team_event.body
      # 作成するボタンをクリックするとTeamEventモデルのカウント数が1増えることを確認する
      expect { find('input.btn-black').click }.to change { TeamEvent.count }.by(1)
      # カレンダー画面に遷移していることを確認する
      expect(current_path).to eq calendars_path
      # カレンダー画面に先ほど作成した予定が記入されていることを確認する
      expect(page).to have_content(@team_event.title.to_s)
    end
  end

  context '予定の作成ができないとき' do
    it '誤った情報では予定の作成ができずにカレンダーページへ戻ってくる' do
      # ログインする
      team_sign_in(@team)
      # カレンダーのリンクが存在することを確認
      expect(page).to have_link('カレンダー')
      # 予定作成画面へ遷移する
      visit new_calendar_path
      # 予定作成画面へ遷移したことを確認する
      expect(current_path).to eq new_calendar_path
      # 不正な情報を入力
      fill_in 'team_event[title]', with: ''
      # 作成するボタンをクリックしてもTeamEventモデルのカウント数が増えないことを確認する
      expect { find('input.btn-black').click }.to change { TeamEvent.count }.by(0)
      # カレンダー画面に遷移せず、作成ページに戻されることを確認する
      expect(current_path).to eq(calendars_path)
      # 戻された際にエラーメッセージが表示されることを確認する
      expect(page).to have_content('エラーが発生したため 予定 は保存されませんでした。')
      expect(page).to have_content('タイトルを入力してください')
    end

    it 'ログインしていない状態では予定を作成することができない' do
      # 予定作成画面へ遷移する
      visit new_calendar_path
      # 遷移されずにログイン画面に戻されることを確認する
      expect(current_path).to eq new_user_session_path
      # 戻されたときにエラーメッセージが表示されることを確認する
      expect(page).to have_content('ログインしてください')
    end
  end
end

RSpec.describe '予定一覧機能', type: :system do
  before do
    @team = FactoryBot.create(:team)
    @team_event = FactoryBot.build(:team_event)
  end

  context '予定一覧機能を確認できるとき' do
    it '予定を作成したのち、カレンダー画面から予定の詳細ページに遷移する' do
      # ログインする
      team_sign_in(@team)
      # カレンダーのリンクが存在することを確認
      expect(page).to have_link('カレンダー')
      # 予定を作成する
      team_calendar(@team_event)
      # カレンダー画面にあるタイトルをクリックする
      click_on(@team_event.title.to_s)
      # 一日の予定一覧が表示されていることを確認する
      expect(page).to have_content('一日の予定一覧')
      # 一覧画面にはタイトルが表示されていることを確認する
      expect(page).to have_content(@team_event.title)
    end
  end

  context '予定一覧機能を確認できないとき' do
    it 'ログインをしたのみで、予定を作成していない場合' do
      # ログインする
      team_sign_in(@team)
      # カレンダーのリンクが存在することを確認
      expect(page).to have_link('カレンダー')
      # カレンダー画面にあるタイトルをクリックする
      expect(page).to have_no_link(@team_event.title.to_s)
    end
  end
end

RSpec.describe '予定編集機能', type: :system do
  before do
    @team = FactoryBot.create(:team)
    @team_event = FactoryBot.build(:team_event)
  end

  context '予定を編集できるとき' do
    it '予定を作成したのち、詳細画面から予定を編集することができる' do
      # ログインする
      team_sign_in(@team)
      # カレンダーのリンクが存在することを確認
      expect(page).to have_link('カレンダー')
      # 予定を作成する
      team_calendar(@team_event)
      # カレンダー画面にあるタイトルをクリックする
      click_on(@team_event.title.to_s)
      # 一日の予定一覧が表示されていることを確認する
      expect(page).to have_content('一日の予定一覧')
      # 一覧画面にはタイトルが表示されていることを確認する
      expect(page).to have_content(@team_event.title)
      # タイトルの下には編集するためのリンクがあることを確認する
      expect(page).to have_link('編集する')
      # 　編集画面に遷移する
      click_on('編集する')
      # 記事の内容を編集する
      fill_in 'team_event[title]', with: 'テスト'
      sleep 1
      # # 変更するボタンをクリックしてもUserEventモデルのカウント数が変わらないことを確認する
      expect { click_on('変更する') }.to change { TeamEvent.count }.by(0)
      # カレンダー画面に遷移していることを確認する
      expect(current_path).to eq calendars_path
      # カレンダー画面に先ほど作成した予定が記入されていることを確認する
      expect(page).to have_content('テスト')
    end
  end

  context '予定を編集できないとき' do
    it 'ログインをしたのみで、予定を作成していない場合' do
      # ログインする
      team_sign_in(@team)
      # カレンダー画面に遷移していることを確認
      expect(current_path).to eq(calendars_path)
      # カレンダー画面には予定が記載されていないことを確認する
      expect(page).to have_no_content(@team_event.title)
    end

    it '編集した内容が不正であるとき' do
      # ログインする
      team_sign_in(@team)
      # カレンダーのリンクが存在することを確認
      expect(page).to have_link('カレンダー')
      # 予定を作成する
      team_calendar(@team_event)
      # カレンダー画面にあるタイトルをクリックする
      click_on(@team_event.title.to_s)
      # 一日の予定一覧が表示されていることを確認する
      expect(page).to have_content('一日の予定一覧')
      # 一覧画面にはタイトルが表示されていることを確認する
      expect(page).to have_content(@team_event.title)
      # タイトルの下には編集するためのリンクがあることを確認する
      expect(page).to have_link('編集する')
      # 　編集画面に遷移する
      click_on('編集する')
      # 記事の内容を編集する
      fill_in 'team_event[title]', with: ''
      sleep 1
      # # 変更するボタンをクリックしてもUserEventモデルのカウント数が変わらないことを確認する
      expect { click_on('変更する') }.to change { TeamEvent.count }.by(0)
      # 編集画面に戻されることを確認する
      expect(page).to have_content('予定を編集')
      # 戻された際にエラーメッセージが表示されていることを確認する
      expect(page).to have_content('エラーが発生したため 予定 は保存されませんでした。')
      expect(page).to have_content('タイトルを入力してください')
    end
  end
end

RSpec.describe '予定削除機能', type: :system do
  before do
    @team = FactoryBot.create(:team)
    @team_event = FactoryBot.build(:team_event)
  end

  context '予定を削除できるとき' do
    it '予定を作成したのち、詳細画面から予定を削除することができる' do
      # ログインする
      team_sign_in(@team)
      # カレンダーのリンクが存在することを確認
      expect(page).to have_link('カレンダー')
      # 予定を作成する
      team_calendar(@team_event)
      # カレンダー画面にあるタイトルをクリックする
      click_on(@team_event.title.to_s)
      # 一日の予定一覧が表示されていることを確認する
      expect(page).to have_content('一日の予定一覧')
      # 一覧画面にはタイトルが表示されていることを確認する
      expect(page).to have_content(@team_event.title)
      # タイトルの下には編集するためのリンクがあることを確認する
      expect(page).to have_link('削除する')
      # 削除するボタンをクリックすると、TeamEventモデルのカウント数が1減ることを確認する
      expect { click_on('削除する') }.to change { TeamEvent.count }.by(-1)
      # カレンダー画面に遷移していることを確認する
      expect(current_path).to eq calendars_path
      # カレンダー画面には削除した内容が表示されていないことを確認する
      expect(page).to have_no_content(@team_event.title)
    end
  end

  context '予定を削除できないとき' do
    it 'ログインをしたのみで、予定を作成していない場合' do
      # ログインする
      team_sign_in(@team)
      # カレンダー画面に遷移していることを確認
      expect(current_path).to eq(calendars_path)
      # カレンダー画面には予定が記載されていないことを確認する
      expect(page).to have_no_content(@team_event.title)
    end

    it 'ログインをしていない場合' do
      visit calendars_path
      # カレンダー画面に遷移せずログイン画面に戻されることを確認する
      expect(current_path).to eq new_user_session_path
      # 戻されたときにエラーメッセージが表示されることを確認する
      expect(page).to have_content('ログインしてください')
    end
  end
end
