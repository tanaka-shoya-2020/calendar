module TeamCalendarSupport
  def team_calendar(team_event)
    visit new_calendar_path
    # 予定作成画面へ遷移したことを確認する
    expect(current_path).to eq new_calendar_path
    # タイトルを入力
    fill_in 'team_event[title]', with: team_event.title
    fill_in 'team_event[start_time]', with: team_event.start_time
    sleep 1
    # 詳細の入力
    fill_in 'team_event[body]', with: team_event.body
    # 作成するボタンをクリックするとTeamEventモデルのカウント数が1増えることを確認する
    expect { find('input.btn-black').click }.to change { TeamEvent.count }.by(1)
  end
end
