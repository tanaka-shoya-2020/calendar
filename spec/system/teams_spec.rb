require 'rails_helper'

RSpec.describe 'チーム新規登録機能', type: :system do
  before do
    @team = FactoryBot.build(:team)
  end

  context 'チーム新規登録ができるとき' do
    it '正しい情報を入力すればチーム新規登録ができてトップページに遷移する' do
      # トップページに遷移する
      visit root_path
      # トップーページにチーム作成ページへ遷移するボタンがあることを確認する
      expect(page).to have_link('チーム作成')
      # チーム作成ページへ遷移する
      visit new_team_registration_path
      # ユーザー情報を入力する
      fill_in 'team[name]', with: @team.name
      fill_in 'team[password]', with: @team.password
      fill_in 'team[password_confirmation]', with: @team.password_confirmation
      # サインアップボタンを押すとユーザーモデルのカウントが1増える
      expect { find('input.btn-black').click }.to change { Team.count }.by(1)
      # カレンダーの画面へ遷移することを確認する
      expect(current_path).to eq calendars_path
      # トップページにログアウトボタンが表示されるいことを確認する
      expect(page).to have_link('チームログアウト')
      # サインアップボタンへ遷移するボタンや、ログインページに遷移するボタンが存在しないことを確認する
      expect(page).to have_no_link('チーム作成')
      expect(page).to have_no_link('チームに参加')
    end
  end
  context 'チーム新規登録ができないとき' do
    it '誤った情報ではチーム新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページにチーム作成へ遷移するボタンがあることを確認する
      expect(page).to have_link('チーム作成')
      # チーム作成へ移動する
      visit new_team_registration_path
      # チーム情報を入力する
      fill_in 'team[name]', with: @team.name
      fill_in 'team[password]', with: ''
      fill_in 'team[password_confirmation]', with: ''
      # サインアップボタンを押してもユーザーモデルのカウント数が変化しないことを確認する
      expect { find('input.btn-black').click }.to change { Team.count }.by(0)
      # サインアップページへ戻されることを確認する
      expect(current_path).to eq team_registration_path
      # サインアップページには登録が失敗したことを示すメッセージがあることを確認する
      expect(page).to have_content('エラーが発生したため チーム は保存されませんでした。')
    end
  end
end

RSpec.describe 'ユーザーログイン機能', type: :system do
  before do
    @team = FactoryBot.create(:team)
  end

  context 'チームに参加できるとき' do
    it '保存されているチームの情報と合致すれば参加できる' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_link('チームに参加')
      # ログインページへ遷移する
      visit new_team_session_path
      # 正しいユーザー情報を入力する
      fill_in 'team[name]', with: @team.name
      fill_in 'team[password]', with: @team.password
      # ログインボタンを押す
      find('input.btn-black').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq calendars_path
      # ログアウトボタンが表示されることを確認する
      expect(page).to have_link('チームログアウト')
      # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_link('チーム作成')
      expect(page).to have_no_link('チームに参加')
    end
  end

  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('チームに参加')
      # ログインページへ遷移する
      visit new_team_session_path
      # ユーザー情報を入力する
      fill_in 'team[name]', with: ''
      fill_in 'team[password]', with: @team.password
      # ログインボタンを押す
      find('input.btn-black').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq team_session_path
      # 戻された後にエラーメッセージが表示されることを確認する
      expect(page).to have_content('チーム名またはパスワードが違います。')
    end
  end
end
