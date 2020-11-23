require 'rails_helper'

RSpec.describe '予定作成機能', type: :system do
  before do
    @sample = FactoryBot.build(:sample)
  end

  context '予定を作成できるとき' do
    it '正しい情報を入力すれば予定を作成できてカレンダーページに遷移する' do
      visit root_path
      # カレンダーのリンクが存在することを確認
      expect(page).to have_link('カレンダー(サンプル)')
      # 予定作成画面へ遷移する
      visit new_sample_path
      # 予定作成画面へ遷移したことを確認する
      expect(current_path).to eq new_sample_path
      # タイトルを入力
      fill_in 'sample_title', with: @sample.title
      # 開始時刻の選択
      find('#sample_start_time_1i').find("option[value='2020']").select_option
      find('#sample_start_time_2i').find("option[value='11']").select_option
      find('#sample_start_time_3i').find("option[value='25']").select_option
      find('#sample_start_time_4i').find("option[value='12']").select_option
      find('#sample_start_time_5i').find("option[value='00']").select_option
      # 終了時刻の選択
      find('#sample_end_time_4i').find("option[value='13']").select_option
      find('#sample_end_time_5i').find("option[value='00']").select_option
      sleep 1
      # 詳細の入力
      fill_in 'sample_body', with: @sample.body
      # 作成するボタンをクリックするとUserEventモデルのカウント数が1増えることを確認する
      expect { find('input.btn-black').click }.to change { Sample.count }.by(1)
      # カレンダー画面に遷移していることを確認する
      expect(current_path).to eq samples_path
      # カレンダー画面に先ほど作成した予定が記入されていることを確認する
      expect(page).to have_content(@sample.title.to_s)
    end
  end
  context '予定の作成ができないとき' do
    it '誤った情報では予定の作成ができずにカレンダーページへ戻ってくる' do
      visit root_path
      # カレンダーのリンクが存在することを確認
      expect(page).to have_link('カレンダー(サンプル)')
      # 予定作成画面へ遷移する
      visit new_sample_path
      # 予定作成画面へ遷移したことを確認する
      expect(current_path).to eq new_sample_path
      # 不正な情報を入力
      fill_in 'sample_title', with: ''
      # 作成するボタンをクリックしてもUserEventモデルのカウント数が増えないことを確認する
      expect { find('input.btn-black').click }.to change { Sample.count }.by(0)
      # カレンダー画面に遷移せず、作成ページに戻されることを確認する
      expect(current_path).to eq(samples_path)
      # 戻された際にエラーメッセージが表示されることを確認する
      expect(page).to have_content('エラーが発生したため 予定 は保存されませんでした。')
      expect(page).to have_content('タイトルを入力してください')
    end
  end
end

RSpec.describe '予定一覧機能', type: :system do
  before do
    @sample = FactoryBot.build(:sample)
  end

  context '予定一覧機能を確認できるとき' do
    it '予定を作成したのち、カレンダー画面から予定の詳細ページに遷移する' do
      visit root_path
      # カレンダーのリンクが存在することを確認
      expect(page).to have_link('カレンダー(サンプル)')
      # 予定を作成する
      sample_create(@sample)
      # カレンダー画面にあるタイトルをクリックする
      click_on(@sample.title.to_s)
      # 一日の予定一覧が表示されていることを確認する
      expect(page).to have_content('一日の予定一覧')
      # 一覧画面にはタイトルが表示されていることを確認する
      expect(page).to have_content(@sample.title)
    end
  end

  context '予定一覧機能を確認できないとき' do
    it '予定を作成していない場合' do
      visit root_path
      # カレンダーのリンクが存在することを確認
      expect(page).to have_link('カレンダー')
      # カレンダー画面にあるタイトルをクリックする
      expect(page).to have_no_link(@sample.title.to_s)
    end
  end
end

RSpec.describe '予定編集機能', type: :system do
  before do
    @sample = FactoryBot.build(:sample)
  end

  context '予定を編集できるとき' do
    it '予定を作成したのち、詳細画面から予定を編集することができる' do
      visit root_path
      # カレンダーのリンクが存在することを確認
      expect(page).to have_link('カレンダー')
      # 予定を作成する
      sample_create(@sample)
      # カレンダー画面にあるタイトルをクリックする
      click_on(@sample.title.to_s)
      # 一日の予定一覧が表示されていることを確認する
      expect(page).to have_content('一日の予定一覧')
      # 一覧画面にはタイトルが表示されていることを確認する
      expect(page).to have_content(@sample.title)
      # タイトルの下には編集するためのリンクがあることを確認する
      expect(page).to have_link('編集する')
      # 　編集画面に遷移する
      click_on('編集する')
      # 記事の内容を編集する
      fill_in 'sample[title]', with: 'テスト'
      sleep 1
      # # 変更するボタンをクリックしてもSampleモデルのカウント数が変わらないことを確認する
      expect { click_on('変更する') }.to change { Sample.count }.by(0)
      # カレンダー画面に遷移していることを確認する
      expect(current_path).to eq samples_path
      # カレンダー画面に先ほど作成した予定が記入されていることを確認する
      expect(page).to have_content('テスト')
    end
  end

  context '予定を編集できないとき' do
    it '予定を作成していない場合' do
      visit root_path
      # カレンダー画面に遷移していることを確認
      expect(current_path).to eq(root_path)
      # カレンダー画面には予定が記載されていないことを確認する
      expect(page).to have_no_content(@sample.title)
    end

    it '編集した内容が不正であるとき' do
      visit root_path
      # カレンダーのリンクが存在することを確認
      expect(page).to have_link('カレンダー')
      # 予定を作成する
      sample_create(@sample)
      # カレンダー画面にあるタイトルをクリックする
      click_on(@sample.title.to_s)
      # 一日の予定一覧が表示されていることを確認する
      expect(page).to have_content('一日の予定一覧')
      # 一覧画面にはタイトルが表示されていることを確認する
      expect(page).to have_content(@sample.title)
      # タイトルの下には編集するためのリンクがあることを確認する
      expect(page).to have_link('編集する')
      # 　編集画面に遷移する
      click_on('編集する')
      # 記事の内容を編集する
      fill_in 'sample[title]', with: ''
      sleep 1
      # # 変更するボタンをクリックしてもSampleモデルのカウント数が変わらないことを確認する
      expect { click_on('変更する') }.to change { Sample.count }.by(0)
      # 編集画面に戻されることを確認する
      expect(page).to have_content('予定を編集')
      # 戻された際にエラーメッセージが表示されていることを確認する
      expect(page).to have_content('エラーが発生したため 予定 は保存されませんでした。')
      expect(page).to have_content('タイトルを入力してください')
    end
  end
end
